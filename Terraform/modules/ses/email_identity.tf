# Amazon Simple Email Service (SES)
#
# Description:
# Amazon SES is an email platform that provides an easy, cost-effective way for you to send and
# receive email using custom email addresses and domains.
#
# This project integrates SES into the applications for email sending. The type of emails can be
# transactional emails, marketing emails, or newsletter emails. Amazon SES also supports a variety
# of deployments including dedicated, shared, or owned IP addresses. Reports on sender statistics
# and an email deliverability dashboard help businesses make every email count.
#
# AWS Documentation:
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sesv2_email_identity
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sesv2_email_identity_feedback_attributes
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_identity_notification_topic

resource "aws_sesv2_email_identity" "default" {
    email_identity = var.domain
    configuration_set_name = aws_sesv2_configuration_set.default.configuration_set_name
    tags = var.tags
}

resource "aws_sesv2_email_identity_feedback_attributes" "example" {
    email_identity = aws_sesv2_email_identity.default.email_identity
    email_forwarding_enabled = false
}

resource "aws_ses_identity_notification_topic" "bounce" {
    identity = aws_sesv2_email_identity.default.email_identity
    notification_type = "Bounce"
    topic_arn = var.sns_topics.ses_notifications.arn
    include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "complaint" {
    identity = aws_sesv2_email_identity.default.email_identity
    notification_type = "Complaint"
    topic_arn = var.sns_topics.ses_notifications.arn
    include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "delivery" {
    identity = aws_sesv2_email_identity.default.email_identity
    notification_type = "Delivery"
    topic_arn = var.sns_topics.ses_notifications.arn
    include_original_headers = true
}