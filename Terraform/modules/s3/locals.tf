# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

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
