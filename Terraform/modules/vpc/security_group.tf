# VPC Security Group
#
# Description:
# Security groups control the traffic that is allowed to reach and leave the resources that it is
# associated. The Security Group below is the default security group of the VPC. You can create
# additional security groups for each VPC. You can associate a security group only with resources in
# the VPC for which it is created.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group

resource "aws_default_security_group" "default_vpc" {
    vpc_id = aws_vpc.default.id
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] VPC"
    })
}
