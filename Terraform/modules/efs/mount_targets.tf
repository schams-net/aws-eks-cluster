# ...

resource "aws_efs_mount_target" "default" {
    count = length(var.subnets)
    file_system_id = aws_efs_file_system.default.id
    subnet_id = var.subnets[count.index].id
    security_groups = [aws_security_group.efs.id]
}
