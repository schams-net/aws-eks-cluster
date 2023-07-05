# ...

locals {
    origin_id_elb_default = "${lower(var.tags.Name)}-loadbalancer-default"
    origin_id_elb_api = "${lower(var.tags.Name)}-loadbalancer-api"
    origin_id_s3_media = "${lower(var.tags.Name)}-s3-bucket-media"
}
