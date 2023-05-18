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

variable "sns_topic_autoscaling_notification" {
}

variable "cloudwatch_log_group" {
}

variable "tags" {
    type = map
}
