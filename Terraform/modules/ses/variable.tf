# Input variables

variable "domain" {
    type = string
    default = "example.com"
}

variable "sns_topics" {
    type = map
}

variable "tags" {
    type = map
}