# Terraform Data Sources
#
# Description:
# Data sources allow Terraform to use information defined outside of Terraform, defined by another
# separate Terraform configuration, or modified by functions.
#
# The following data sources are predefined CloudFront policies managed by AWS.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/data-sources

data "aws_cloudfront_origin_request_policy" "managed_all_viewer" {
    name = "Managed-AllViewer"
}

data "aws_cloudfront_origin_request_policy" "managed_all_viewer_and_cloudfront_headers" {
    name = "Managed-AllViewerAndCloudFrontHeaders-2022-06"
}

data "aws_cloudfront_cache_policy" "managed_caching_disabled" {
    name = "Managed-CachingDisabled"
}
