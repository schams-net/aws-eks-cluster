# ...

resource "aws_cloudfront_origin_access_control" "s3" {
    name = "${var.tags.Name}"
    description = "[${var.tags.Name}] Origin Access Control (S3)"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}
