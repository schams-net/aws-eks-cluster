# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

locals {
    # AWS account ID
    account_id = data.aws_caller_identity.current.account_id

    # AWS RDS Aurora cluster (IAM authentication)
    rds_database_access = templatefile(
        "${path.module}/templates/rds_database_access.tftpl",
        {
            region = data.aws_region.current.name
            account = data.aws_caller_identity.current.account_id
            resource = var.rds_aurora_cluster.cluster_resource_id
            username = "dbuser"
        }
    )

    # AWS Secrets Manager
    secrets_manager = templatefile(
        "${path.module}/templates/secrets_manager.tftpl",
        {
            resources = jsonencode([
                var.secrets.rds_aurora_access_details.arn,
                var.secrets.mq_broker_access_details.arn,
                var.secrets.s3_buckets.arn,
                var.secrets.redis_cluster_endpoint.arn
            ])
        }
    )

    # AWS S3 buckets
    s3_buckets = templatefile(
        "${path.module}/templates/s3_buckets.tftpl",
        {
            s3_bucket_media_arn = var.s3_buckets.media.arn,
            s3_bucket_ugc_arn = var.s3_buckets.ugc.arn
        }
    )
}
