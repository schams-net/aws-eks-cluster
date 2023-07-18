# Amazon CloudFront Distribution
#
# Description:
# Amazon CloudFront is a service that speeds up the distribution of your static and dynamic web
# content to your users. CloudFront delivers your content through a worldwide network of data centers
# called edge locations. When a user requests content that you're serving with CloudFront, the request
# is routed to the edge location that provides the lowest latency (time delay), so that content is
# delivered with the best possible performance.
# If a user requests content that is not in that edge location, CloudFront retrieves it from an
# origin that you've defined, for example a web application.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution

resource "aws_cloudfront_distribution" "default" {
    comment = "[${var.tags.Name}] CloudFront distribution"
    is_ipv6_enabled = true
    price_class = "PriceClass_All"
    http_version = "http2"
    wait_for_deployment = false
    retain_on_delete = false
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
        custom_header {
            name = "CloudFront-Token"
            value = random_id.hash.hex
        }
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
        custom_header {
            name = "CloudFront-Token"
            value = random_id.hash.hex
        }
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
        function_association {
            event_type = "viewer-request"
            function_arn = aws_cloudfront_function.add_index_html.arn
        }
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
