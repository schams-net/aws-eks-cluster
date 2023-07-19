# Amazon RDS Aurora Serverless (MySQL or PostgreSQL)
#
# Description:
# Amazon Aurora Serverless is an on-demand, autoscaling configuration for Amazon Aurora.
# It automatically starts up, shuts down, and scales capacity up or down based on your
# application's needs. Amazon Aurora Serverless v2 scales instantly to hundreds of thousands
# of transactions in a fraction of a second. As it scales, it adjusts capacity in fine-grained
# increments to provide the right amount of database resources that the application needs.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance

resource "aws_rds_cluster_instance" "serverless_db01a" {

    # Hint: Use the meta-argument "count" and the expression "count.index" to deploy a DB instance
    # in every available subnet across all availability zones (read/write and replicas), depending
    # on the configured number of subnets.
    #count = ...

    identifier = "aurora-serverless-${data.aws_availability_zones.available.names[0]}"
    cluster_identifier = aws_rds_cluster.default.id
    instance_class = "db.serverless"
    engine = aws_rds_cluster.default.engine
    engine_version = aws_rds_cluster.default.engine_version

    publicly_accessible = false
    apply_immediately = true
    availability_zone = data.aws_availability_zones.available.names[0]

    # Can't configure a value for "network_type": its value will be decided
    # automatically based on the result of applying this configuration.
    #network_type = "DUAL"

    db_subnet_group_name = aws_db_subnet_group.default.name
    copy_tags_to_snapshot = true

    tags = merge(var.tags, {
        Name = "${var.tags.Name} ${data.aws_availability_zones.available.names[0]}"
    })
}
