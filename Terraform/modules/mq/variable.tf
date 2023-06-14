# Input variables

variable "vpc" {
}

variable "subnets" {
}

variable "mq_broker_username" {
    type = string
    default = "ExampleUser"
}

variable "tags" {
    type = map
}
