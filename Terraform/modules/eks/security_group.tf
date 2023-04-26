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

resource "aws_security_group" "control_plane" {
    name = "${var.tags.Name}-ControlPlaneSecurityGroup"
    description = "[${var.tags.Name}] Cluster communication with worker nodes"
    vpc_id = var.vpc.id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] Kubernetes Control Plane"
    })
}
