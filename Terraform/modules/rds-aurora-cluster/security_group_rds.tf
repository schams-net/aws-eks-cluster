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
    name = "${lower(var.tags.Name)}-rds-aurora"
    description = "${var.tags.Name} RDS Aurora cluster"
    vpc_id = var.vpc.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        # @TODO
        #cidr_blocks = ["10.10.110.0/24", "10.10.120.0/24", "10.10.130.0/24"]
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] RDS Aurora cluster"
    })
}
