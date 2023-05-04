# AWS Secrets Manager
#
# Description:
# ...
#
# AWS Documentation:
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret

resource "aws_secretsmanager_secret" "rds_aurora_cluster_endpoint" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-rds-aurora-cluster-endpoint"
    description = "[${var.tags.Name}] RDS Aurora cluster endpoint"
    recovery_window_in_days = 0
    #policy = 
    tags = var.tags
}
