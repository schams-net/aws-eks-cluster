# Amazon RDS Subnet Group
#
# Description:
# Subnets are segments of a VPC's IP address range that you designate to group your resources based
# on security and operational needs. A DB subnet group is a collection of subnets (typically private)
# that you create in a VPC and that you then designate for your DB clusters.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group

resource "aws_db_subnet_group" "default" {
    name = "${lower(var.tags.Name)}"
    subnet_ids = var.subnets[*].id
}
