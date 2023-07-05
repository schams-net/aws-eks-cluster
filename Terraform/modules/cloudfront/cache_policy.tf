# CloudFront cache policy

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
