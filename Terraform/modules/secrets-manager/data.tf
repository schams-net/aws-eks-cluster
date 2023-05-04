# ...

data "template_file" "rds_aurora_cluster_endpoint" {
    template = "${file("${path.module}/json/rds_aurora_cluster_endpoint.tpl")}"
    vars = {
        cluster_endpoint = var.rds_aurora_cluster.endpoint
    }
}
