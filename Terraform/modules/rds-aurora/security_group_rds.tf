# Amazon RDS Aurora Serverless (MySQL)
#
# Description:
# @TODO
#
# AWS Documentation:
# @TODO
#
# Terraform Documentation:
# @TODO

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
