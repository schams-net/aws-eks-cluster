# AWS IAM Role "Amazon EKS Node Group"
#
# Description:
# The resource provides an IAM role for the Kubernetes cluster. AWS-managed IAM policies are attached
# to the role.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role" "eks" {
    name = "${var.tags.Name}-AmazonEKS"
    assume_role_policy = file("${path.module}/json/assume_role_eks.json")
    tags = {
        Name = "${var.tags.Name}-AmazonEKS"
        billing-id = var.tags.billing-id
    }
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = aws_iam_role.eks.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "amazon_eks_vpc_resource_controller" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role = aws_iam_role.eks.name
}
