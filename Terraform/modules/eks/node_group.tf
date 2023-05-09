# AWS-managed EKS Node Group
#
# Description:
# An EKS Node Group, which can provision and optionally update an Auto Scaling Group of Kubernetes
# worker nodes compatible with EKS.
#
# AWS Documentation:
# https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

data "aws_ssm_parameter" "eks_ami_release_version" {
    name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.default.version}/amazon-linux-2/recommended/release_version"
}

resource "aws_eks_node_group" "default" {
    cluster_name = aws_eks_cluster.default.name
    version = aws_eks_cluster.default.version
    release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
    node_group_name = "example"
    node_role_arn = var.iam_roles.ec2.arn
    ami_type = "AL2_x86_64"
    instance_types = ["t3.small"]
    subnet_ids = var.subnets[*].id

    launch_template {
        id = aws_launch_template.default.id
        version = aws_launch_template.default.latest_version
    }

    scaling_config {
        min_size = 2
        desired_size = 2
        max_size = 4
    }

    labels = {
    }

    update_config {
        max_unavailable = 1
    }

    # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
    # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
    depends_on = [var.eks_node_group_role_policies]

    tags = var.tags
}
