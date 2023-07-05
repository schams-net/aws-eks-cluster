# AWS Secrets Manager
#
# Description:
# ...
#
# AWS Documentation:
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secrets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version

resource "aws_secretsmanager_secret" "rds_aurora_cluster_endpoint" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_rds_aurora_cluster_endpoint"
    description = "[${var.tags.Name}] RDS Aurora cluster endpoint"
    recovery_window_in_days = 0
    #policy = 
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "rds_aurora_cluster_endpoint" {
    secret_id = aws_secretsmanager_secret.rds_aurora_cluster_endpoint.id
    secret_string = local.rds_aurora_cluster_endpoint
}

resource "aws_secretsmanager_secret" "mq_broker_access_details" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_mq_broker_access_details"
    description = "[${var.tags.Name}] Access details of the Amazon MQ broker user"
    recovery_window_in_days = 0
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "mq_broker_access_details" {
    secret_id = aws_secretsmanager_secret.mq_broker_access_details.id
    secret_string = local.mq_broker_access_details
}

resource "aws_secretsmanager_secret" "s3_buckets" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_s3_buckets"
    description = "[${var.tags.Name}] S3 bucket names"
    recovery_window_in_days = 0
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "s3_buckets" {
    secret_id = aws_secretsmanager_secret.s3_buckets.id
    secret_string = local.s3_buckets
}
