# Input variables

variable "cidr_block" {
    type = string
    description = "Base CIDR block for the VPC"
    default = "192.168.0.0/16"
}

variable "tags" {
    type = map
}
