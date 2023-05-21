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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "efs" {
    name = "${var.tags.Name}-ElasticFileSystemSecurityGroup"
    description = "[${var.tags.Name}] Elastic File System (EFS)"
    vpc_id = var.vpc.id

    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = var.subnets[*].cidr_block
    }

    # @TODO remove Security Group rule below
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] Elastic File System (EFS)"
    })
}