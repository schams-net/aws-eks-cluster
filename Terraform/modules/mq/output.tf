# Output variables

output "mq_broker" {
    value = aws_mq_broker.default
}

output "mq_broker_access_details" {
    sensitive = true
    value = {
        username = var.mq_broker_username
        password = random_password.password.result
    }
}
