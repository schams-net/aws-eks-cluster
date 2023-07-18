# Amazon ElastiCache for Redis
#
# Description:
# AWS CloudFront Origin Access Control (OAC) is used by CloudFront distributions with an Amazon S3 bucket
# as the origin. OAC sends authenticated requests to an Amazon S3 origin and is AWS' recommended method
# to access restrict an Amazon S3 origin.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control

resource "aws_cloudfront_origin_access_control" "s3" {
    name = "${var.tags.Name}"
    description = "[${var.tags.Name}] Origin Access Control (S3)"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}
