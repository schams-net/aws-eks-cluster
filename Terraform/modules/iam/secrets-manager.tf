# ...

# ...
data "template_file" "secrets_manager" {
    template = "${file("${path.module}/templates/secrets-manager.tpl")}"
    vars = {
        region = data.aws_region.current.name
        account = local.account_id
    }
}

# Inline policy
#resource "aws_iam_role_policy" "secrets_manager" {
#    name = "secrets-manager"
#    role = aws_iam_role.eks_node_group.id
#    policy = data.template_file.secrets_manager.rendered
#}

# ------------------------------------------------------------------------------

# IAM policy
resource "aws_iam_policy" "secrets_manager" {
    name = "${var.tags.Name}-SecretsManager"
    policy = data.template_file.secrets_manager.rendered
}

# ------------------------------------------------------------------------------
