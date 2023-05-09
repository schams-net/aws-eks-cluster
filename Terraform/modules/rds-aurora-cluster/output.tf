# Output variables

output "rds_aurora_cluster" {
    value = aws_rds_cluster.default
}

output "rds_aurora_instances" {
    value = [
        aws_rds_cluster_instance.serverless_db01a
    ]
}
