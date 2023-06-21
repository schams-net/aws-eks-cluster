# ...

# IAM policy
resource "aws_iam_policy" "secrets_manager" {
    name = "${var.tags.Name}-SecretsManager"
    policy = local.secrets_manager
}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
    policy_arn = aws_iam_policy.secrets_manager.arn
    #role = aws_iam_role.irsa.name
    role = aws_iam_role.eks_node_group.name
}
