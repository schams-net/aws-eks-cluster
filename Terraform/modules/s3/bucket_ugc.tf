# ...

resource "aws_s3_bucket" "ugc" {
    bucket = "${lower(var.tags.Name)}.ugc.${var.random_identifier.hex}"
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
