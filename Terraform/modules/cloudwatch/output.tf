# Output variables

output "log_groups" {
    value = {
        eks_cluster = aws_cloudwatch_log_group.eks_cluster
    }
}
