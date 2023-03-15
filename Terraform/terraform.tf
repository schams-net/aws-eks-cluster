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
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest
# https://registry.terraform.io/providers/hashicorp/random/latest

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.0"
        }
    }
}
