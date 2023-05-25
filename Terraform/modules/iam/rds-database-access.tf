# ...

# Inline policy
resource "aws_iam_role_policy" "rds_database_access" {
    name = "rds-database-access"
    role = aws_iam_role.eks_node_group.id
    policy = local.rds_database_access
}
