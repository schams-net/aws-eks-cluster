# IAM Role Inline Policy
#
# Description:
# Resource provides an IAM role inline policy.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
# https://developer.hashicorp.com/terraform/tutorials/aws/aws-iam-policy

# Inline policy
resource "aws_iam_role_policy" "rds_database_access" {
    name = "rds-database-access"
    role = aws_iam_role.eks_node_group.id
    policy = local.rds_database_access
}
