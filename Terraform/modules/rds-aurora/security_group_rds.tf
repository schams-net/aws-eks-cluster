# Security Group
#
# Description:
# Security groups control the traffic that is allowed to reach and leave the resources that it is
# associated.
#
# AWS Documentation:
# See AWS documentation "Amazon RDS Aurora", in particular:
# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Overview.RDSSecurityGroups.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "rds" {
    #name = "${lower(var.tags.Name)}-rds-aurora"
    name = "${var.tags.Name}-AuroraCluster"
    description = "[${var.tags.Name}] RDS Aurora cluster"
    vpc_id = var.vpc.id

    # MySQL/MariaDB
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.subnets[*].cidr_block
    }

    # PostgreSQL
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = var.subnets[*].cidr_block
    }

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] RDS Aurora cluster"
    })
}
