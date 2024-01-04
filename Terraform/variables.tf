# Global variables

variable "profile" {
    description = "AWS CLI profile"
    type = string
    default = "default"
}

variable "region" {
    description = "Region, e.g. us-east-1 or ap-southeast-2"
    type = string
    default = "ap-southeast-2"
}

# See "Secrets Manager" for basic auth access details (user name and password)
variable "ses_notifications_endpoint" {
    type = string
    default = "https://example.com/ses-feedback-notifications"
}

variable "tags" {
    type = map
    default = {
        "Name"  = "KubernetesCluster"
        "billing-id" = "anomaly"
    }
}
