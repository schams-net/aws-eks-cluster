# Terraform Provider Configuration
#
# Description:
# Terraform relies on plugins called providers to interact with cloud providers, SaaS providers, and
# other APIs. Terraform configurations must declare which providers they require so that Terraform
# can install and use them.

# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest
#
provider "aws" {
    profile = var.profile
    region = var.region
}

# The awk_eks does allow you to get the host and client_certificate
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#attributes-reference
#
# Note that we have to configure the exec block for aws
# https://developer.hashicorp.com/terraform/tutorials/kubernetes/helm-provider#review-the-helm-configuration
#
# Without this the Kubernetes version and other context is unavailable to the helm provider.
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs
#
provider "helm" {
    kubernetes {
        host = module.aws_eks.cluster.endpoint
        cluster_ca_certificate = base64decode(module.aws_eks.cluster.certificate_authority[0].data)
        exec {
            api_version = "client.authentication.k8s.io/v1beta1"
            args = ["eks", "get-token", "--cluster-name", module.aws_eks.cluster.name]
            command = "aws"
        }
    }
}

# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
#
provider "kubernetes" {
    host = module.aws_eks.cluster.endpoint
    cluster_ca_certificate = base64decode(module.aws_eks.cluster.certificate_authority[0].data)
    exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        args = ["eks", "get-token", "--cluster-name", module.aws_eks.cluster.name]
        command = "aws"
    }
}

# Terrafom Documentation:
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
#
provider "kubectl" {
    load_config_file = false
    host = module.aws_eks.cluster.endpoint
    cluster_ca_certificate = base64decode(module.aws_eks.cluster.certificate_authority[0].data)
}
