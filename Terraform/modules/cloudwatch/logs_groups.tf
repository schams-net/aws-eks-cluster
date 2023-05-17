# ...

resource "aws_cloudwatch_log_group" "eks_cluster" {
    # Log group name format: /aws/eks/<cluster-name>/cluster
    # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    name = "/aws/eks/${var.eks_cluster.name}/cluster"

    retention_in_days = 7

    tags = var.tags
}
