# Amazon CloudFront Functions
#
# Description:
# Provides a CloudFront Function resource. With CloudFront Functions in Amazon CloudFront, you can
# write lightweight functions in JavaScript for high-scale, latency-sensitive CDN customizations.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cloudfront-functions.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_function

resource "aws_cloudfront_function" "add_index_html" {
    name = "${lower(var.tags.Name)}-add-index-html"
    runtime = "cloudfront-js-1.0"
    comment = "Adds index.html if the URI does not have a file name or file extension"
    publish = true
    code = file("${path.module}/functions/add-index-html.js")
}
