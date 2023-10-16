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

output "iam_user_credentials" {
    value = {
        username = aws_iam_user.user_s3_media_bucket.name
        access_key_id = aws_iam_access_key.user_s3_media_bucket.id
        secret_access_key = aws_iam_access_key.user_s3_media_bucket.secret
    }
}