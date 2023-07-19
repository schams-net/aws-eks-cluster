# Terraform Providers
#
# Description:
# Terraform relies on plugins called providers to interact with cloud providers, SaaS providers, and
# other APIs. Terraform configurations must declare which providers they require so that Terraform
# can install and use them.
#
# The "hashicorp/aws" provider is the official provider by Hashicorp to work with Amazon Web
# Services (AWS) resources.
#
# The "hashicorp/random" provider supports the use of randomness within Terraform configurations.
# This is a logical provider, which works entirely within Terraform logic and does not interact with
# any other services.
#
# The "hashicorp/helm" provider is used to deploy software packages in Kubernetes. "Helm" is a package
# manager for Kubernetes.
#
# The "hashicorp/kubernetes" provider is used to interact with the resources supported by Kubernetes.
#
# The "gavinbunney/kubectl" provider is used to manage Kubernetes resources in Terraform. The core
# of this provider is the kubectl_manifest resource, allowing free-form yaml to be processed and
# applied against Kubernetes. This yaml object is then tracked and handles creation, updates and
# deleted seamlessly - including drift detection.
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest
# https://registry.terraform.io/providers/hashicorp/random/latest
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.0"
        }
        helm = {
            source = "hashicorp/helm"
            version = "~> 2.0"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~> 2.0"
        }
        kubectl = {
            source = "gavinbunney/kubectl"
            version = "~> 1.0"
        }
    }
}
