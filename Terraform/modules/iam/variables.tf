# Input variables

variable "rds_aurora_cluster" {
}

variable "eks_cluster" {
}

variable "secrets" {
    type = map
}

variable "tags" {
    type = map
}
