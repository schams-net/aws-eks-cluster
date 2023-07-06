# Output variables

output "distribution" {
    value = aws_cloudfront_distribution.default
}

output "http_header_token" {
    value = random_id.hash.hex
}
