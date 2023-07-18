# Amazon CloudFront Cache Policy
#
# Description:
# CloudFront provides a set of managed policies that you can attach to any of your distribution's
# cache behaviors. CloudFront also lets you create your custom cache policies. You can use a cache
# policy to improve your cache hit ratio by controlling the values (URL query strings, HTTP headers,
# and cookies) that are included in the cache key.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-the-cache-key.html
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/controlling-origin-requests.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_cache_policy

resource "aws_cloudfront_cache_policy" "static_assets_1_day" {
    name = "${var.tags.Name}-StaticAssets-1-day"
    comment = "Static assets (cached for 1 day)"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 86400
    parameters_in_cache_key_and_forwarded_to_origin {
        cookies_config {
            cookie_behavior = "none"
        }
        headers_config {
            header_behavior = "whitelist"
            headers {
                items = ["Origin", "Host"]
            }
        }
        query_strings_config {
            query_string_behavior = "none"
        }
        enable_accept_encoding_gzip = true
        enable_accept_encoding_brotli = true
    }
}
