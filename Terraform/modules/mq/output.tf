# Output variables

output "mq_broker" {
    value = aws_mq_broker.default
}

# Available ActiveMQ endpoints (apparantly in this order):
# - ssl://<broker-identifier>.mq.<region>.amazonaws.com:61617
# - amqp+ssl://<broker-identifier>.mq.<region>.amazonaws.com:5671
# - stomp+ssl://<broker-identifier>.mq.<region>.amazonaws.com:61614
# - mqtt+ssl://<broker-identifier>.mq.<region>.amazonaws.com:8883
# - wss://<broker-identifier>.mq.<region>.amazonaws.com:61619

output "mq_broker_access_details" {
    sensitive = true
    value = {
        username = var.mq_broker_username
        password = random_password.password.result
        endpoint = aws_mq_broker.default.instances.0.endpoints.1
    }
}
