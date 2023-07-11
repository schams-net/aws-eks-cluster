# Output variables

output "secrets" {
    value = {
        rds_aurora_cluster_endpoint = aws_secretsmanager_secret.rds_aurora_cluster_endpoint
        mq_broker_access_details = aws_secretsmanager_secret.mq_broker_access_details
        s3_buckets = aws_secretsmanager_secret.s3_buckets
        redis_cluster_endpoint = aws_secretsmanager_secret.redis_cluster_endpoint
    }
}
