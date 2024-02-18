# Amazon IAM OpenID Connect Provider for Amazon EKS
#
# Description:
# IAM OIDC identity providers are entities in IAM that describe an external identity provider (IdP)
# service that supports the OpenID Connect (OIDC) standard, such as Google or Salesforce. You use an
# IAM OIDC identity provider when you want to establish trust between an OIDC-compatible IdP and your
# AWS account.
#
# Additional notes and resource:
# The TLS provider provides utilities for working with Transport Layer Security keys and certificates.
# It provides resources that allow private keys, certificates and certificate requests to be created
# as part of a Terraform deployment.
#
# The "aws_iam_policy_document" data source generates an IAM policy document in JSON format for use
# with resources that expect policy documents such as aws_iam_policy.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider

data "tls_certificate" "irsa" {
    url = var.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "irsa" {
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = data.tls_certificate.irsa.certificates[*].sha1_fingerprint
    url = data.tls_certificate.irsa.url
}
