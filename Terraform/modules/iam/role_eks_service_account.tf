# IAM Roles for Service Accounts (IRSA)

# IAM role "*-IAMRoleForKubernetesServiceAccount"
resource "aws_iam_role" "irsa" {
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    name = "${var.tags.Name}-IAMRoleForKubernetesServiceAccount"
}
