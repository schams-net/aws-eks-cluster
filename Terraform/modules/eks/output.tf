# Output variables

output "cluster" {
    value = aws_eks_cluster.default
}

output "node_group" {
    value = aws_eks_node_group.default
}
