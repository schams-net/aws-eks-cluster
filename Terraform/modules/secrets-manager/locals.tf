# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

locals {
    rds_aurora_access_details = templatefile(
        "${path.module}/templates/rds_aurora_access_details.tftpl",
        {
            cluster_endpoint = var.rds_aurora_cluster.endpoint
            username = replace(lower(var.tags.Name), "/[^a-z0-9]/", "")
            password = random_password.password.result
        }
    )
    s3_buckets = templatefile(
        "${path.module}/templates/s3_buckets.tftpl",
        {
            s3_bucket_media = var.s3_buckets.media.id
            s3_bucket_ugc = var.s3_buckets.ugc.id
        }
    )
    redis_cluster_endpoint = templatefile(
        "${path.module}/templates/redis_cluster_endpoint.tftpl",
        {
            cluster_endpoint = var.redis_cluster.cache_nodes[0].address
        }
    )
    ses_notifications_basic_auth = templatefile(
        "${path.module}/templates/ses_notifications_basic_auth.tftpl",
        {
            username = local.ses_notifications_basic_auth_username
            password = local.ses_notifications_basic_auth_password
            endpoint = var.ses_notifications_endpoint
        }
    )
    ses_notifications_basic_auth_username = sha1(random_uuid.basic_authentication_username.result)
    ses_notifications_basic_auth_password = sha1(random_uuid.basic_authentication_password.result)
}
