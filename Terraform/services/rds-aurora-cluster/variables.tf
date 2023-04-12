# Input variables

variable "vpc" {
}

variable "subnets" {
}

variable "availability_zones" {
    type = list(string)
}

#variable "kms_key_rds_aurora_arn" {
#    type = string
#}

variable "subnet_group_name" {
    type = string
    default = "kubernetes-cluster"
}

variable "tags" {
    type = map
}
