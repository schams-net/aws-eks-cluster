# Amazon Simple Notification Service
#
# Description:
# This resource provides an SNS topic resource.
#
# AWS Documentation:
# https://docs.aws.amazon.com/sns/latest/dg/welcome.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic

resource "aws_sns_topic" "auto_scaling_notifications" {
    name = "${var.tags.Name}-auto-scaling-notifications"
    tags = var.tags
}

resource "aws_sns_topic" "redis_notifications" {
    name = "${var.tags.Name}-redis-notifications"
    tags = var.tags
}

resource "aws_sns_topic" "ses_notifications" {
    name = "${var.tags.Name}-ses-notifications"
    tags = var.tags
}