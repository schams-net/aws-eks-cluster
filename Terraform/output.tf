# Output variables

output "rds_aurora_cluster_endpoint" {
    sensitive = false
    value = module.aws_rds_cluster.rds_aurora_cluster.endpoint
}