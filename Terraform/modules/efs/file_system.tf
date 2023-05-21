# ...

resource "aws_efs_file_system" "default" {
    #kms_key_id = var.kms_key_efs_arn
    encrypted = false
    performance_mode = "generalPurpose"
    tags = var.tags
}
