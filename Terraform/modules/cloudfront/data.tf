# ...

data "aws_cloudfront_origin_request_policy" "managed_all_viewer" {
    name = "Managed-AllViewer"
}

data "aws_cloudfront_origin_request_policy" "managed_all_viewer_and_cloudfront_headers" {
    name = "Managed-AllViewerAndCloudFrontHeaders-2022-06"
}

data "aws_cloudfront_cache_policy" "managed_caching_disabled" {
    name = "Managed-CachingDisabled"
}
