# Amazon Simple Email Service (SES)
#
# Description:
# Configuration sets are groups of rules that you can apply to your verified identities. A verified
# identity is a domain, subdomain, or email address you use to send email through Amazon SES. When
# you apply a configuration set to an email, all of the rules in that configuration set are applied
# to the email.
#
# AWS Documentation:
# https://docs.aws.amazon.com/ses/latest/dg/using-configuration-sets.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sesv2_configuration_set

resource "aws_sesv2_configuration_set" "default" {
    configuration_set_name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-${replace(var.domain, "/[^a-z0-9_-]/", "-")}"

    # Specify if Transport Layer Security (TLS) is require or optional
    delivery_options {
        tls_policy = "OPTIONAL"
    }

    # Enable/disable reputation metrics tracking
    reputation_options {
        reputation_metrics_enabled = true
    }

    # Enable/disable email sending
    sending_options {
        sending_enabled = true
    }

    # List that contains the reasons that email addresses are automatically added
    # to the suppression list for your AWS account
    suppression_options {
        suppressed_reasons = ["BOUNCE", "COMPLAINT"]
    }

#    # The domain to use for tracking open and click events
#    tracking_options {
#        custom_redirect_domain = "example.com"
#    }

    tags = var.tags
}

resource "aws_sesv2_configuration_set_event_destination" "default" {
    configuration_set_name = aws_sesv2_configuration_set.default.configuration_set_name
    event_destination_name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-${replace(var.domain, "/[^a-z0-9_-]/", "-")}"

    event_destination {
        enabled = true
        # Valid values: SEND, REJECT, BOUNCE, COMPLAINT, DELIVERY, OPEN, CLICK, RENDERING_FAILURE, DELIVERY_DELAY, SUBSCRIPTION
        matching_event_types = ["BOUNCE", "COMPLAINT", "REJECT"]

        sns_destination {
            topic_arn = var.sns_topics.ses_notifications.arn
        }
    }
}