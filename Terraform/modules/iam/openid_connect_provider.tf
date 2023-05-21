# OpenID Connect Provider for Amazon EKS

data "tls_certificate" "irsa" {
    url = var.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        actions = ["sts:AssumeRoleWithWebIdentity"]
        effect = "Allow"

        condition {
            test = "StringEquals"
            variable = "${replace(aws_iam_openid_connect_provider.irsa.url, "https://", "")}:sub"
            values = [
               "system:serviceaccount:kube-system:aws-node",
               "system:serviceaccount:kube-system:efs-csi-controller-sa"
            ]
        }

        principals {
            identifiers = [aws_iam_openid_connect_provider.irsa.arn]
            type = "Federated"
        }
    }
}

resource "aws_iam_openid_connect_provider" "irsa" {
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = data.tls_certificate.irsa.certificates[*].sha1_fingerprint
    url = data.tls_certificate.irsa.url
}
