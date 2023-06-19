# ...

# AWS load balancer controller
# Elastic Load Balancing
# https://aws.amazon.com/elasticloadbalancing/
resource "helm_release" "aws-load-balancer-controller" {
    name = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = var.namespace

    set {
        name = "clusterName"
        value = var.eks_cluster.name
    }

    set {
        name = "serviceAccount.create"
        value = "true"
    }

    set {
        name = "serviceAccount.name"
        value = "aws-load-balancer-controller"
    }

    depends_on = [
        var.eks_cluster
    ]
}
