# Output variables

output "secrets" {
    value = {
        rds_aurora_cluster_endpoint = aws_secretsmanager_secret.rds_aurora_cluster_endpoint
        mq_broker_access_details = aws_secretsmanager_secret.mq_broker_access_details
    }
}
