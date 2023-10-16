# IAM users

resource "aws_iam_user" "user_s3_media_bucket" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}_s3_media_bucket"
    path = "/"

    # When destroying this user, destroy even if it has non-Terraform-managed
    # IAM access keys, login profile or MFA devices.
    force_destroy = true

    tags = var.tags
}

resource "aws_iam_access_key" "user_s3_media_bucket" {
    user = aws_iam_user.user_s3_media_bucket.name
    status = "Active"
}

# inline policy
resource "aws_iam_user_policy" "user_s3_media_bucket" {
    name = "read-write-s3-media-bucket"
    user = aws_iam_user.user_s3_media_bucket.name
    policy = local.user_s3_media_bucket
}