# Terraform Local Values
#
# Description:
# A local value assigns a name to an expression, so you can use the name multiple times within a
# module instead of repeating the expression.
#
# Terrafom Documentation:
# https://developer.hashicorp.com/terraform/language/values/locals

locals {
    ses_notifications_endpoint = "https://${var.ses_notifications_basic_auth.username}:${var.ses_notifications_basic_auth.password}@${regex("^(https?://)(.*)$", var.ses_notifications_endpoint)[1]}"
}
