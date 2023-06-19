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
# @TODO: "hashicorp/helm"
# @TODO: "hashicorp/kubernetes"
# @TODO: "hashicorp/kubectl"
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest
# https://registry.terraform.io/providers/hashicorp/random/latest
# @TODO: add links

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
            #version = "2.10.1"
            version = "~> 2.0"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
            #version = "2.21.1"
            version = "~> 2.0"
        }
        kubectl = {
            source = "gavinbunney/kubectl"
            #version = "1.14.0"
            version = "~> 1.0"
        }
    }
}
