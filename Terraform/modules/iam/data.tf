# Terraform data sources

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "tls_certificate" "irsa" {
    url = var.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "assume_role_with_web_identity" {
    statement {
        actions = ["sts:AssumeRoleWithWebIdentity"]
        effect = "Allow"

        condition {
            test = "StringEquals"
            variable = "${replace(aws_iam_openid_connect_provider.irsa.url, "https://", "")}:sub"
            values = [
               "system:serviceaccount:default:aws-secrets-manager"
            ]
        }

        principals {
            identifiers = [aws_iam_openid_connect_provider.irsa.arn]
            type = "Federated"
        }
    }
}
