# ...

# ...
data "template_file" "secrets_manager" {
    template = "${file("${path.module}/json/secrets-manager.tpl")}"
    vars = {
        region = var.region
        account = local.account_id
    }
}

# Inline policy
resource "aws_iam_role_policy" "secrets_manager" {
    name = "secrets-manager"
    role = aws_iam_role.eks_node_group.id
    policy = data.template_file.secrets_manager.rendered
}
