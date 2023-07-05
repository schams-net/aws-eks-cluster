# ...

resource "aws_cloudfront_distribution" "default" {
    comment = "[${var.tags.Name}] CloudFront distribution"
    is_ipv6_enabled = true
    price_class = "PriceClass_All"
    retain_on_delete = true
    http_version = "http2"
    wait_for_deployment = false
    enabled = true

    #aliases = ["example.com"]

    origin {
        domain_name = var.origins.s3_media
        origin_id = local.origin_id_s3_media
        origin_access_control_id = aws_cloudfront_origin_access_control.s3.id
    }

    origin {
        domain_name = var.origins.elb_api
        origin_id = local.origin_id_elb_api
        custom_origin_config {
            http_port = "80"
            https_port = "443"
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_ssl_protocols = ["TLSv1.2"]
            origin_read_timeout = 30
        }
    }

    origin {
        domain_name = var.origins.elb_default
        origin_id = local.origin_id_elb_default
        custom_origin_config {
            http_port = "80"
            https_port = "443"
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_ssl_protocols = ["TLSv1.2"]
            origin_read_timeout = 30
        }
    }

    default_cache_behavior {
        allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = local.origin_id_elb_default
        viewer_protocol_policy = "redirect-to-https"
        #viewer_protocol_policy = "allow-all"
        compress = true
        smooth_streaming = false
        cache_policy_id = data.aws_cloudfront_cache_policy.managed_caching_disabled.id
        origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_all_viewer_and_cloudfront_headers.id
    }

    # Cache behavior with precedence 2
    ordered_cache_behavior {
        path_pattern     = "/api/*"
        allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods = ["GET", "HEAD"]
        target_origin_id = local.origin_id_elb_api
        viewer_protocol_policy = "redirect-to-https"
        compress = true
        smooth_streaming = false
        cache_policy_id = data.aws_cloudfront_cache_policy.managed_caching_disabled.id
        origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_all_viewer_and_cloudfront_headers.id
    }

    # Cache behavior with precedence 1
    ordered_cache_behavior {
        path_pattern     = "/media/*"
        allowed_methods = ["GET", "HEAD", "OPTIONS"]
        cached_methods = ["GET", "HEAD", "OPTIONS"]
        target_origin_id = local.origin_id_s3_media
        viewer_protocol_policy = "redirect-to-https"
        compress = true
        smooth_streaming = false
        cache_policy_id = data.aws_cloudfront_cache_policy.managed_caching_disabled.id
        #origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_all_viewer_and_cloudfront_headers.id
    }

    viewer_certificate {
        #acm_certificate_arn = "arn:aws:acm:us-east-1:${local.account_id}:certificate/0bb38158-4b80-4662-a1c6-f265cef2e5a3"
        #ssl_support_method = "sni-only"
        #minimum_protocol_version = "TLSv1.2_2021"

        cloudfront_default_certificate = true
        minimum_protocol_version = "TLSv1"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

#    logging_config {
#        include_cookies = false
#        bucket = "example.com"
#        prefix = "cloudfront/example.com/"
#    }

}
