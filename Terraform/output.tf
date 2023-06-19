# Output variables

output "rds_aurora_cluster_endpoint" {
    sensitive = false
    value = module.aws_rds_aurora.cluster.endpoint
}

output "eks_cluster_endpoint" {
    sensitive = false
    value = module.aws_eks.cluster.endpoint
}
