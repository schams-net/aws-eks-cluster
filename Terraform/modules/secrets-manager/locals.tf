# ...

locals {
    rds_aurora_cluster_endpoint = templatefile(
        "${path.module}/templates/rds_aurora_cluster_endpoint.tftpl",
        {
            cluster_endpoint = var.rds_aurora_cluster.endpoint
        }
    )
}
