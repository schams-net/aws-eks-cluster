# IAM Roles for Service Accounts (IRSA)

# IAM role "*-IAMRoleForKubernetesServiceAccount"
resource "aws_iam_role" "irsa" {
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    name = "${var.tags.Name}-IAMRoleForKubernetesServiceAccount"
}

# ------------------------------------------------------------------------------

# Policy for the Amazon EFS CSI Driver
resource "aws_iam_policy" "efs_csi" {
    name = "${var.tags.Name}-EFS-CSI-Driver"
    path = "/"
    description = "Policy for the Amazon EFS CSI Driver"
    policy = file("${path.module}/json/efs-csi-driver-policy.json")
    tags = merge(var.tags, {
        Name = "${var.tags.Name}-EFS-CSI-Driver"
    })
}

resource "aws_iam_role_policy_attachment" "efs_csi" {
    policy_arn = aws_iam_policy.efs_csi.arn
    role = aws_iam_role.irsa.name
}
