# ...

resource "aws_s3_bucket_policy" "media" {
    bucket = aws_s3_bucket.media.id
    policy = local.bucket_media_policy
}
