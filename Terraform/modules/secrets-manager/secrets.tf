# AWS Secrets Manager
#
# Description:
# The AWS Secrets Manager is a secrets management service that helps you protect access to your
# applications, services, and IT resources. Secrets Manager lets you store a JSON document which
# allows you to manage any text blurb that is 64 KB or smaller. The data is stored encrypted at rest.
#
# AWS Documentation:
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secrets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version

resource "aws_secretsmanager_secret" "rds_aurora_access_details" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_rds_aurora_access_details"
    description = "[${var.tags.Name}] RDS Aurora cluster endpoint"
    recovery_window_in_days = 0
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "rds_aurora_access_details" {
    secret_id = aws_secretsmanager_secret.rds_aurora_access_details.id
    secret_string = local.rds_aurora_access_details
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

resource "aws_secretsmanager_secret" "redis_cluster_endpoint" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_redis_cluster_endpoint"
    description = "[${var.tags.Name}] ElastiCache for Redis cluster endpoint"
    recovery_window_in_days = 0
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "redis_cluster_endpoint" {
    secret_id = aws_secretsmanager_secret.redis_cluster_endpoint.id
    secret_string = local.redis_cluster_endpoint
}

resource "aws_secretsmanager_secret" "ses_notifications_basic_auth" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_ses_notifications_basic_auth"
    description = "[${var.tags.Name}] Randomly generated access details for the basic authentication (SES notifications through SNS subscription)"
    recovery_window_in_days = 0
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "ses_notifications_basic_auth" {
    secret_id = aws_secretsmanager_secret.ses_notifications_basic_auth.id
    secret_string = local.ses_notifications_basic_auth
}
