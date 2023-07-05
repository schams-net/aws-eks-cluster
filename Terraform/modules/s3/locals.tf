# ...

locals {
    # S3 bucket policy
    bucket_media_policy = templatefile(
        "${path.module}/templates/bucket_media_policy.tftpl",
        {
            s3_bucket_arn: aws_s3_bucket.media.arn
            cloudfront_distribution_arn: var.cloudfront_distribution.arn
        }
    )
}
