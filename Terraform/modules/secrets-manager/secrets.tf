# AWS Secrets Manager
#
# Description:
# ...
#
# AWS Documentation:
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secrets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version

resource "aws_secretsmanager_secret" "rds_aurora_cluster_endpoint" {
    name = "${replace(lower(var.tags.Name), "/[^a-z0-9]/", "")}-rds-aurora-cluster-endpoint"
    description = "[${var.tags.Name}] RDS Aurora cluster endpoint"
    recovery_window_in_days = 0
    #policy = 
    tags = var.tags
}

resource "aws_secretsmanager_secret_version" "rds_aurora_cluster_endpoint" {
    secret_id = aws_secretsmanager_secret.rds_aurora_cluster_endpoint.id
    secret_string = data.template_file.rds_aurora_cluster_endpoint.rendered
}

# Retrieve secret, for example, using the AWS CLI:
#
# aws --profile default --region ap-southeast-2 \
#   secretsmanager get-secret-value \
#   --secret-id KubernetesCluster-rds-aurora-cluster-endpoint \
#   | jq '.SecretString | fromjson.cluster_endpoint'
