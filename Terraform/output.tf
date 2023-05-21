# Output variables

output "file_system_id" {
    sensitive = false
    value = module.aws_efs.file_system.id
}

output "rds_aurora_cluster_endpoint" {
    sensitive = false
    value = module.aws_rds_aurora.cluster.endpoint
}
