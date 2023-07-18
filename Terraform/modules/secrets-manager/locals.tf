# ...

locals {
    rds_aurora_access_details = templatefile(
        "${path.module}/templates/rds_aurora_access_details.tftpl",
        {
            cluster_endpoint = var.rds_aurora_cluster.endpoint
            username = replace(lower(var.tags.Name), "/[^a-z0-9]/", "")
            password = random_password.password.result
        }
    )
    mq_broker_access_details = templatefile(
        "${path.module}/templates/mq_broker_access_details.tftpl",
        {
            username = var.mq_broker_access_details.username
            password = var.mq_broker_access_details.password
            endpoint = var.mq_broker_access_details.endpoint
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
}

# The random_password resource uses a cryptographic random number generator.
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
#
# Password rules for ActiveMQ: min 12 characters, at least 4 unique characters.
# Can't contain commas (,), colons (:), equals signs (=), spaces or non-printable ASCII characters
resource "random_password" "password" {
    length = 16
    special = true
    override_special = "!#$%&*?"
}
