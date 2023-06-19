# Input variables

variable "eks_cluster" {
}

variable "namespace" {
    default = "kube-system"
}

variable "tags" {
    type = map
}
