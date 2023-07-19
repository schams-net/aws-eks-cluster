# Internet Gateway
#
# Description:
# An internet gateway is a horizontally scaled, redundant, and highly available VPC component that
# allows communication between your VPC and the internet.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.default.id
    tags = var.tags
}
