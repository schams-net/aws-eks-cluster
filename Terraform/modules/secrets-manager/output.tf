# Output variables

output "secrets" {
    value = {
        rds_aurora_access_details = aws_secretsmanager_secret.rds_aurora_access_details
        s3_buckets = aws_secretsmanager_secret.s3_buckets
        redis_cluster_endpoint = aws_secretsmanager_secret.redis_cluster_endpoint
        ses_notifications_basic_auth = aws_secretsmanager_secret.ses_notifications_basic_auth
    }
}

output "ses_notifications_basic_auth" {
    sensitive = true
    value = {
        username = local.ses_notifications_basic_auth_username
        password = local.ses_notifications_basic_auth_password
    }
}
