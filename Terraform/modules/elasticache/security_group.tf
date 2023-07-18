# Security Group
#
# Description:
# Security groups control the traffic that is allowed to reach and leave the resources that it is
# associated.
#
# Note: Amazon ElastiCache security groups are only applicable to clusters that are not running in
# an Amazon Virtual Private Cloud environment (VPC). If you are running in an Amazon Virtual Private
# Cloud, Security Groups is not available in the console navigation pane. If you are running your
# ElastiCache nodes in an Amazon VPC, you control access to your clusters with Amazon VPC security
# groups, which are different from ElastiCache security groups. For more information about using
# ElastiCache in an Amazon VPC, see Amazon VPCs and ElastiCache security.
#
# AWS Documentation:
# See AWS documentation "Amazon ElastiCache for Redis".
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "redis" {
    name = "${var.tags.Name}-ElastiCacheSecurityGroup"
    description = "[${var.tags.Name}] Amazon ElastiCache for Redis"
    vpc_id = var.vpc.id

    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = var.subnets[*].cidr_block
    }

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] Amazon ElastiCache for Redis"
    })
}
