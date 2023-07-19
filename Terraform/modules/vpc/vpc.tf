# Virtual Private Cloud (VPC)
#
# Description:
# A VPC is a virtual network that is logically isolated from other virtual networks in the AWS Cloud.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/configure-your-vpc.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "default" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    assign_generated_ipv6_cidr_block = false
    tags = var.tags
}
