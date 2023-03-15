# Input variables

variable "vpc" {
}

variable "eks_role" {
}

variable "eks_role_policies" {
}

variable "eks_node_group_role" {
}

variable "eks_node_group_role_policies" {
}

variable "subnets" {
}

variable "tags" {
    type = map
}
