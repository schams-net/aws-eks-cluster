# Input variables

variable "rds_aurora_cluster" {
}

variable "mq_broker_access_details" {
    type = map
}

variable "s3_buckets" {
    type = map
}

variable "tags" {
    type = map
}
