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

resource "aws_security_group" "mq" {
    name = "${var.tags.Name}-MessageQueueSecurityGroup"
    description = "[${var.tags.Name}] Amazon Message Queue (MQ)"
    vpc_id = var.vpc.id

    ingress {
        from_port = 5671
        to_port = 5671
        protocol = "tcp"
        cidr_blocks = var.subnets[*].cidr_block
    }

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] Amazon Message Queue (MQ)"
    })
}
