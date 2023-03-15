# Global variables

variable "profile" {
    description = "AWS CLI profile"
    type = string
    default = "default"
}

variable "region" {
    description = "Region, e.g. us-east-1 or ap-southeast-2"
    type = string
    default = "ap-southeast-2"
}

variable "tags" {
    type = map
    default = {
        "Name"  = "KubernetesCluster"
        "billing-id" = "k8cluster"
    }
}
