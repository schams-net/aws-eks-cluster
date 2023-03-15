# @TODO
#
# Description:
# @TODO
#
# AWS Documentation:
# @TODO
#
# Terrafom Documentation:
# @TODO

resource "aws_iam_role" "eks_node_group" {
    name = "${var.tags.Name}RoleForAmazonEKSNodeGroup"
    assume_role_policy = file("${path.module}/eks_node_group_assume_role.json")
    tags = {
        Name = "${var.tags.Name}RoleForAmazonEKSNodeGroup"
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
