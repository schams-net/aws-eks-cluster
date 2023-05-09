# ...

# ...
data "template_file" "rds_database_access" {
    template = "${file("${path.module}/json/rds-database-access.tpl")}"
    vars = {
        region = var.region
        account = local.account_id
        resource = var.rds_aurora_instances[0].dbi_resource_id
        username = "dbuser"
    }
}

# Inline policy
resource "aws_iam_role_policy" "rds_database_access" {
    name = "rds-database-access"
    role = aws_iam_role.eks_node_group.id
    policy = data.template_file.rds_database_access.rendered
}
