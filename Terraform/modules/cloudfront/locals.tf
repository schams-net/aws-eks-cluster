# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

locals {
    origin_id_elb_default = "${lower(var.tags.Name)}-loadbalancer-default"
    origin_id_elb_api = "${lower(var.tags.Name)}-loadbalancer-api"
    origin_id_s3_media = "${lower(var.tags.Name)}-s3-bucket-media"
}
