# ...

resource "random_integer" "rand" {
    min = 10000
    max = 99999
}

locals {
    # AWS account ID
    account_id = data.aws_caller_identity.current.account_id

    # AWS Secrets Manager
    rds_database_access = templatefile(
        "${path.module}/templates/rds_database_access.tftpl",
        {
            region = data.aws_region.current.name
            account = data.aws_caller_identity.current.account_id
            resource = var.rds_aurora_instances[0].dbi_resource_id
            username = "dbuser"
        }
    )

    # AWS Secrets Manager
    secrets_manager = templatefile(
        "${path.module}/templates/secrets_manager.tftpl",
        {
            region = data.aws_region.current.name
            account = local.account_id
        }
    )
}
