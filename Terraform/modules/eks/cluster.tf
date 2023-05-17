# Amazon Elastic Kubernetes Service (EKS)
#
# Description:
# Amazon EKS is a managed service that you can use to run Kubernetes on AWS. Kubernetes is an
# open-source system for automating the deployment, scaling, and management of containerized
#
# AWS Documentation:
# https://aws.amazon.com/eks/
# https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

resource "aws_eks_cluster" "default" {
    name = var.tags.Name
    role_arn = var.iam_roles.eks.arn

	# Kubernetes master version. If you do not specify a value, the latest available version at
	# resource creation is used and no upgrades will occur except those automatically triggered by
	# EKS.
	version = "1.25"

    vpc_config {

        # List of subnet IDs. Must be in at least two different availability zones. Amazon EKS
        # creates cross-account elastic network interfaces in these subnets to allow communication
        # between your worker nodes and the Kubernetes control plane.
        #subnet_ids = var.subnets[count.index].id
        #subnet_ids = [var.subnets.0.id, var.subnets.1.id, var.subnets.2.id]
        subnet_ids = var.subnets[*].id

        # List of security group IDs for the cross-account elastic network interfaces that Amazon
        # EKS creates to use to allow communication between your worker nodes and the Kubernetes
        # control plane.
        security_group_ids = [aws_security_group.control_plane.id]

        # Whether the Amazon EKS private API server endpoint is enabled (default: false).
        endpoint_private_access = false

        # Whether the Amazon EKS public API server endpoint is enabled (default: true).
        endpoint_public_access = true

        # List of CIDR blocks that can access the Amazon EKS public API server endpoint when enabled.
        # Terraform will only perform drift detection of its value when present in a configuration.
        # Default: ["0.0.0.0/0"].
        public_access_cidrs = ["0.0.0.0/0"]
    }

    kubernetes_network_config {
        # "10.0.0.0/8" or "172.16.0.0/12" or "192.168.0.0/16".
        # Must not overlap with any CIDR block assigned to the VPC that you selected for VPC.
        service_ipv4_cidr = "10.100.0.0/16"

        # Valid values are ipv4 (default) and ipv6.
        ip_family = "ipv4"
    }

    # List of the desired control plane logging to enable.
    # Valid options: "api", "audit", "authenticator", "controllerManager", "scheduler"
    # See https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    enabled_cluster_log_types = ["api", "audit"]

    # Ensure that IAM role permissions are created before and deleted after EKS cluster handling.
    # Otherwise, EKS will not be able to delete EKS managed EC2 infrastructure such as Security
	# Groups.
    depends_on = [var.eks_role_policies]

    lifecycle {
        ignore_changes = [tags, tags_all]
    }

    timeouts {
        create = "20m"
        update = "30m"
        delete = "30m"
    }

	tags = var.tags
}
