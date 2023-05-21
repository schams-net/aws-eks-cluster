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

resource "aws_db_subnet_group" "default" {
    name = "${lower(var.tags.Name)}"
    subnet_ids = var.subnets[*].id
}
