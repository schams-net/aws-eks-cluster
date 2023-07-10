# Output variables

output "log_groups" {
    value = {
        eks_cluster = aws_cloudwatch_log_group.eks_cluster
        redis_slow_log = aws_cloudwatch_log_group.redis_slow_log
        redis_engine_log = aws_cloudwatch_log_group.redis_engine_log
    }
}
