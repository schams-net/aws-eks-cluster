# Output variables

output "roles" {
    value = {
        "eks" = aws_iam_role.eks
        "ec2" = aws_iam_role.eks_node_group
    }
}

output "eks_role_policies" {
    value = [
        aws_iam_role_policy_attachment.amazon_eks_cluster_policy,
        aws_iam_role_policy_attachment.amazon_eks_vpc_resource_controller
    ]
}

output "eks_node_group_role_policies" {
    value = [
        aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
        aws_iam_role_policy_attachment.amazon_eks_cni_policy,
        aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only
    ]
}

output "iam_policy_secrets_manager" {
    value = aws_iam_policy.secrets_manager
}
