# Amazon Elastic Kubernetes Service (EKS)
#
# Description:
# The following three add-ons are included with every EKS cluster by default.
#
# kube-proxy is a network proxy that runs on each node in a Kubernetes cluster. The role of this
# add-on is to reflect the services defined in the cluster and manage the networking rules on a node
# to allow communications to the pods that back a service.
# https://kubernetes.io/docs/concepts/overview/components/#kube-proxy
#
# CoreDNS provides DNS services within EKS Kubernetes clusters. DNS allows individual containers to
# easily discover and connect to other containers within the cluster.
# https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
# https://coredns.io/
#
# Amazon EKS supports native VPC networking with the Amazon VPC Container Network Interface (CNI)
# plugin for Kubernetes. Using this plugin allows Kubernetes pods to have the same IP address inside
# the pod as they do on the VPC network.
# https://docs.aws.amazon.com/eks/latest/userguide/pod-networking.html
#
# AWS Documentation:
# https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon

resource "aws_eks_addon" "kube_proxy" {
    cluster_name = aws_eks_cluster.default.name
    addon_name = "kube-proxy"

    # Kubernetes version 1.23
    #addon_version = "v1.23.17-minimal-eksbuild.3"
    #addon_version = "v1.23.16-eksbuild.2"

    # Kubernetes version 1.24
    #addon_version = "v1.24.17-minimal-eksbuild.2"

    # Kubernetes version 1.25
    #addon_version = "v1.25.14-minimal-eksbuild.2"

    # Kubernetes version 1.26
    #addon_version = "v1.26.9-minimal-eksbuild.2"

    # Kubernetes version 1.27
    #addon_version = "v1.27.6-minimal-eksbuild.2"

    # Kubernetes version 1.28
    #addon_version = "v1.28.2-minimal-eksbuild.2"
    #addon_version = "v1.28.2-eksbuild.2"

    # Kubernetes version 1.29
    #addon_version = "v1.29.0-eksbuild.1" (default)
    addon_version = "v1.29.0-eksbuild.3"

    # Don't try to install the add-on until the EKS node group is available
    depends_on = [ aws_eks_node_group.default ]
}

resource "aws_eks_addon" "coredns" {
    cluster_name = aws_eks_cluster.default.name
    addon_name = "coredns"

    # Kubernetes version 1.23
    #addon_version = "v1.8.7-eksbuild.7"

    # Kubernetes version 1.24
    #addon_version = "v1.9.3-eksbuild.7"

    # Kubernetes version 1.25
    #addon_version = "v1.9.3-eksbuild.7"

    # Kubernetes version 1.26
    #addon_version = "v1.9.3-eksbuild.7"

    # Kubernetes version 1.27
    #addon_version = "v1.10.1-eksbuild.4"

    # Kubernetes version 1.28
    #addon_version = "v1.10.1-eksbuild.4"

    # Kubernetes version 1.29
    #addon_version = "v1.11.1-eksbuild.4" (default)
    addon_version = "v1.11.1-eksbuild.6"

    # Don't try to install the add-on until the EKS node group is available
    depends_on = [ aws_eks_node_group.default ]
}

resource "aws_eks_addon" "vpc_cni" {
    cluster_name = aws_eks_cluster.default.name
    addon_name = "vpc-cni"

    # Kubernetes version 1.23, 1.24, 1.25, 1.26, 1.27, 1.28
    #addon_version = "v1.15.1-eksbuild.1"

    # Kubernetes version 1.29
    #addon_version = "v1.16.0-eksbuild.1" (default)
    addon_version = "v1.16.2-eksbuild.1"

    # Don't try to install the add-on until the EKS node group is available
    depends_on = [ aws_eks_node_group.default ]
}
