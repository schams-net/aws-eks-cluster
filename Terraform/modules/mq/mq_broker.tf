# AWS Secrets Manager
#
# Description:
# ...
#
# AWS Documentation:
# ...
#
# Terrafom Documentation:
# ...

resource "aws_mq_broker" "default" {
    broker_name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-mq-broker"

    engine_type = "ActiveMQ"
    # https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/activemq-version-management.html
    engine_version = "5.17.2"

    host_instance_type = "mq.t2.micro"
    apply_immediately = false

    # The deployment mode of the broker: SINGLE_INSTANCE or ACTIVE_STANDBY_MULTI_AZ
    deployment_mode = "SINGLE_INSTANCE"

    # List of subnet IDs in which to launch the broker. A SINGLE_INSTANCE deployment
    # requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires two subnets.
    subnet_ids = [var.subnets[0].id]
    security_groups = [aws_security_group.mq.id]

    encryption_options {
        #kms_key_id = <ARN>
        use_aws_owned_key = true
    }

    configuration {
        id = aws_mq_configuration.default.id
        revision = aws_mq_configuration.default.latest_revision
    }

    user {
        username = var.mq_broker_username
        password = random_password.password.result
        console_access = false
    }

    tags = var.tags
}

# The random_password resource uses a cryptographic random number generator.
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
#
# Password rules for ActiveMQ: min 12 characters, at least 4 unique characters.
# Can't contain commas (,), colons (:), equals signs (=), spaces or non-printable ASCII characters
resource "random_password" "password" {
    length = 16
    special = true
    override_special = "!#$%&*?"
}
