# Amazon ElastiCache for Redis
#
# Description:
# Redis compatible in-memory data store that can be used to power real-time applications with
# sub-millisecond latency. Amazon ElastiCache for Redis is fully managed by AWS, scalable and
# highly available.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/WhatIs.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster

resource "aws_elasticache_cluster" "redis" {
    cluster_id = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-redis"

    engine = "redis"
    engine_version = "7.0"
    port = 6379

    # Smallest types are: cache.t2.micro, cache.t3.micro, cache.t4g.micro
    node_type = "cache.t2.micro"

    # Initial number of cache nodes that the cache cluster will have.
    # For Redis, this value must be 1.
    num_cache_nodes = 1

    # Only one can be specified: "engine" or "replication_group_id"
    #replication_group_id = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-redis"

    parameter_group_name = "default.redis7"
    auto_minor_version_upgrade = true

    network_type = "ipv4"
    subnet_group_name = aws_elasticache_subnet_group.example.name
    security_group_ids = [aws_security_group.redis.id]

    apply_immediately = true
    #final_snapshot_identifier = ...

    log_delivery_configuration {
        destination = var.cloudwatch_log_groups.redis_slow_log.name
        destination_type = "cloudwatch-logs"
        log_type = "slow-log"
        # Valid values for the log format: "text" or "json"
        log_format = "text"
    }

    log_delivery_configuration {
        destination = var.cloudwatch_log_groups.redis_engine_log.name
        destination_type = "cloudwatch-logs"
        log_type = "engine-log"
        # Valid values for the log format: "text" or "json"
        log_format = "text"
    }

    # Daily backups
    # Set snapshot_retention_limit to zero (0) to turn off backups.
    snapshot_retention_limit = 0
    snapshot_window = "05:00-09:00"

    maintenance_window = "tue:15:00-tue:16:59"

    notification_topic_arn = var.sns_topics.redis_notifications.arn
    #depends_on = [ var.sns_topics.redis_notifications ]

    tags = var.tags
}

resource "aws_elasticache_subnet_group" "example" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-redis"
    subnet_ids = var.subnets[*].id
}
