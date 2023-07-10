# ...

resource "aws_cloudwatch_log_group" "eks_cluster" {
    # Log group name format: /aws/eks/<cluster-name>/cluster
    # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    name = "/aws/eks/${var.tags.Name}/cluster"
    retention_in_days = 7
    tags = var.tags
}

resource "aws_cloudwatch_log_group" "redis_slow_log" {
    name = "/aws/elasticache/${var.tags.Name}/slow_log"
    retention_in_days = 7
    tags = var.tags
}

resource "aws_cloudwatch_log_group" "redis_engine_log" {
    name = "/aws/elasticache/${var.tags.Name}/engine_log"
    retention_in_days = 7
    tags = var.tags
}
