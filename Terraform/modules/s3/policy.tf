# Amazon S3 Bucket Policy
#
# Description:
# This resource attaches a policy to the "media" S3 bucket that allows CloudFront to access objects
# stored in the S3 bucket.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-policies.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

resource "aws_s3_bucket_policy" "media" {
    bucket = aws_s3_bucket.media.id
    policy = local.bucket_media_policy
}
