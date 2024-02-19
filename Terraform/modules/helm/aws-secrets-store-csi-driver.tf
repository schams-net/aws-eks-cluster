# AWS Secret Store CSI Driver Provider
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html

resource "helm_release" "aws_secrets_store_csi_driver" {
    name = "aws-secrets-store-csi-driver"
    repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    chart = "secrets-store-csi-driver"
    namespace = var.namespace

    set {
        name = "clusterName"
        value = var.eks_cluster.name
    }

    # https://secrets-store-csi-driver.sigs.k8s.io/topics/secret-auto-rotation.html
    # When the secret/key is updated in the AWS Secrets Manager after the initial pod deployment,
    # the pods continue to use the old secret value. If the "secret rotation" feature of the Secrets
    # Store CSI driver enabled, the driver periodically remount the secrets in the SecretProviderClass.
    # WARNING: This will cause additional API calls which results in additional charges.
#    set {
#        name = "enableSecretRotation"
#        value = "true"
#    }

#    set {
#        name = "rotationPollInterval"
#        value = "3600s"
#    }

    depends_on = [
        var.eks_cluster
    ]
}
