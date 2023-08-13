# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

locals {
    origin_id_load_balancer = "${lower(var.tags.Name)}-loadbalancer"
    origin_id_s3_media = "${lower(var.tags.Name)}-s3-bucket-media"
}
