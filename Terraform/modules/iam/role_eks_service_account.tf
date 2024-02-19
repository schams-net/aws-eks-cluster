# AWS IAM Role "Amazon EKS Node Group"
#
# Description:
# The resource provides an IAM role for the service account. AWS-managed IAM policies and inline
# policies can be attached to the role.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role" "service_account" {
    name = "${var.tags.Name}-AmazonEKS-ServiceAccount"
    assume_role_policy = data.aws_iam_policy_document.assume_role_with_web_identity.json
    tags = merge(var.tags, {
        Name = "${var.tags.Name}-AmazonEKS-ServiceAccount"
    })
}

# Inline policy
resource "aws_iam_role_policy" "service_account_aws_secrets_manager" {
    name = "aws-secrets-manager"
    role = aws_iam_role.service_account.id
    policy = local.secrets_manager
}
