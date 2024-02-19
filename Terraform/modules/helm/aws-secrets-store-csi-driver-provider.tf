# AWS Secret Store CSI Driver Provider
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

resource "helm_release" "aws_secrets_store_csi_driver_provider" {
    name = "aws-secrets-store-csi-driver-provider"
    repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws/"
    chart = "secrets-store-csi-driver-provider-aws"
    namespace = var.namespace

    set {
        name = "clusterName"
        value = var.eks_cluster.name
    }

    depends_on = [
        var.eks_cluster
    ]
}
