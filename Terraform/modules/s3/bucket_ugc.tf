# Amazon Simple Storage Service (Amazon S3)
#
# Description:
# Amazon S3 is an object storage service that offers industry-leading scalability, data availability,
# security, and performance. The service provides management features so that you can optimize,
# organize, and configure access to your data to meet your specific business, organizational, and
# compliance requirements.
#
# The S3 bucket "ugc" stores user generated content (UGC). These objects are encrypted at rest by
# AWS' server-side encryption feature.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonS3/latest/userguide//Welcome.html
# https://docs.aws.amazon.com/AmazonS3/latest/userguide//serv-side-encryption.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration

resource "aws_s3_bucket" "ugc" {
    bucket = "${lower(var.tags.Name)}.ugc.${var.random_identifier.hex}"

    # force_destroy: Indicates that all objects (including any locked objects)
    # should be deleted from the bucket when the bucket is destroyed. Otherwise
    # a "terraform destroy" can fail (if the bucket still contains objects).
    #force_destroy = true

    tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ugc" {
    bucket = aws_s3_bucket.ugc.bucket
    rule {
        bucket_key_enabled = true
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}
