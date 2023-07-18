# Amazon CloudWatch Log Groups
#
# Description:
# Amazon CloudWatch Logs let you monitor, store, and access log files from a wide range of AWS sources
# in a central place. You can then easily view the logs, search them for specific error codes or patterns,
# filter them based on specific fields, or archive them securely for future analysis. CloudWatch Logs
# enables you to see all of your logs, regardless of their source, as a single and consistent flow of
# events ordered by time.
#
# CloudWatch Logs also supports querying your logs with a powerful query language, auditing and masking
# sensitive data in logs, and generating metrics from logs using filters or an embedded log format.
#
# You can choose the retention policy for each log group for a period between one day to 10 years, or
# retain the logs indefinitely.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatchLogsConcepts.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group

resource "aws_cloudwatch_log_group" "eks_cluster" {
    # Log group name format: /aws/eks/<cluster-name>/cluster
    # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    name = "/aws/eks/${var.tags.Name}/cluster"
    retention_in_days = 7
    tags = var.tags
}

resource "aws_cloudwatch_log_group" "redis_slow_log" {
    name = "/aws/elasticache/${var.tags.Name}/slow_log"
    retention_in_days = 7
    tags = var.tags
}

resource "aws_cloudwatch_log_group" "redis_engine_log" {
    name = "/aws/elasticache/${var.tags.Name}/engine_log"
    retention_in_days = 7
    tags = var.tags
}
