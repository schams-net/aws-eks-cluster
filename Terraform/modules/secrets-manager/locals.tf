# ...

locals {
    rds_aurora_cluster_endpoint = templatefile(
        "${path.module}/templates/rds_aurora_cluster_endpoint.tftpl",
        {
            cluster_endpoint = var.rds_aurora_cluster.endpoint
        }
    )
    mq_broker_access_details = templatefile(
        "${path.module}/templates/mq_broker_access_details.tftpl",
        {
            username = var.mq_broker_access_details.username
            password = var.mq_broker_access_details.password
        }
    )
}
