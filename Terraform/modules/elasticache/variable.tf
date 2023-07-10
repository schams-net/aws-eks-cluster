# Input variables

variable "vpc" {
}

variable "subnets" {
}

variable "cloudwatch_log_groups" {
    type = map
}

variable "sns_topics" {
    type = map
}

variable "tags" {
    type = map
}
