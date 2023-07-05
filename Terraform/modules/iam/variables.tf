# Input variables

variable "rds_aurora_cluster" {
}

variable "eks_cluster" {
}

variable "s3_buckets" {
    type = map
}

variable "secrets" {
    type = map
}

variable "tags" {
    type = map
}
