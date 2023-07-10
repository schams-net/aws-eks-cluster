# Input variables

variable "vpc" {
}

variable "subnets" {
}

variable "iam_roles" {
}

variable "eks_role_policies" {
}

variable "eks_node_group_role_policies" {
}

variable "sns_topics" {
    type = map
}

variable "cloudwatch_log_groups" {
    type = map
}

variable "tags" {
    type = map
}
