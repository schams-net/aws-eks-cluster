# ...

# IAM policy
resource "aws_iam_policy" "secrets_manager" {
    name = "${var.tags.Name}-SecretsManager"
    policy = local.secrets_manager
}
