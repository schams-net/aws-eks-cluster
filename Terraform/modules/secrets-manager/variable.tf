# Input variables

variable "rds_aurora_cluster" {
}

variable "s3_buckets" {
    type = map
}

variable "redis_cluster" {
}

variable "ses_notifications_endpoint" {
    type = string
}

variable "tags" {
    type = map
}
