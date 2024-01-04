# Amazon Simple Notification Service
#
# Description:
# This resource provides an SNS topic resource.
#
# AWS Documentation:
# https://docs.aws.amazon.com/sns/latest/dg/welcome.html
# https://docs.aws.amazon.com/sns/latest/dg/sns-subscribe-https-s-endpoints-to-topic.html
# https://docs.aws.amazon.com/sns/latest/dg/sns-http-https-endpoint-as-subscriber.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription
#
# Important note:
# After you subscribe your endpoint, Amazon SNS sends a subscription confirmation request to the
# HTTPS endpoint. The application behind the endpoint needs to receive the request, extract a value
# from the data (SubscribeURL) and visit this URL to confirm the subscription. Otherwise, the
# subscription remains in a "pending" state.

resource "aws_sns_topic_subscription" "ses_notifications" {
    topic_arn = aws_sns_topic.ses_notifications.arn
    protocol = "https"
    endpoint = local.ses_notifications_endpoint

    # If raw message delivery is enabled ("true"), the original message is directly passed, not
    # wrapped in JSON with the original message in the message property. The default is false.
    raw_message_delivery = false
}
