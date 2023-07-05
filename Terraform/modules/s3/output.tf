# Output variables

output "buckets" {
    value = {
        "media": aws_s3_bucket.media
        "ugc": aws_s3_bucket.ugc
    }
}
