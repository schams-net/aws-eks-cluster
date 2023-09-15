# AWS IAM Role "Amazon EKS Node Group"
#
# Description:
# The resource provides an IAM role for the Kubernetes cluster node group (EC2 instances and the
# applications running as pods on the instances). Several IAM policies managed by AWS are attached
# to the role, plus some custom policies allowing the application to access services such as the
# Secrets Manager and S3 buckets.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy

resource "aws_iam_role" "eks_node_group" {
    name = "${var.tags.Name}-AmazonEKS-NodeGroup"
    assume_role_policy = file("${path.module}/json/assume_role_ec2.json")
    tags = {
        Name = "${var.tags.Name}-AmazonEKS-NodeGroup"
        billing-id = var.tags.billing-id
    }
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.eks_node_group.name
}

# inline policy
resource "aws_iam_role_policy" "amazon_secrets_manager" {
    name = "secrets-manager"
    role = aws_iam_role.eks_node_group.name
    policy = local.secrets_manager
}

# inline policy
resource "aws_iam_role_policy" "s3_buckets" {
    name = "s3-buckets"
    role = aws_iam_role.eks_node_group.name
    policy = local.s3_buckets
}

# inline policy
resource "aws_iam_role_policy" "simple_email_service" {
    name = "simple-email-service"
    role = aws_iam_role.eks_node_group.name
    policy = local.simple_email_service
}