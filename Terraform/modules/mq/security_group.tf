# Security Group
#
# Description:
# Security groups control the traffic that is allowed to reach and leave the resources that it is
# associated.
#
# AWS Documentation:
# See AWS documentation "Amazon MQ", in particular:
# https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/using-amazon-mq-securely.html#amazon-mq-vpc-security-groups
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
