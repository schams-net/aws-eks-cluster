# Terraform Provider Configuration
#
# Description:
# Terraform relies on plugins called providers to interact with cloud providers, SaaS providers, and
# other APIs. Terraform configurations must declare which providers they require so that Terraform
# can install and use them.
#
# Terrafom Documentation:
# @TODO

provider "aws" {
    profile = var.profile
    region = var.region
}
