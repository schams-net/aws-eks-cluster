# AWS Secrets Manager
#
# Description:
# ...
#
# AWS Documentation:
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version

data "template_file" "rds_aurora_cluster_endpoint" {
    template = "${file("${path.module}/json/rds_aurora_cluster_endpoint.tpl")}"
    vars = {
        cluster_endpoint = var.rds_aurora_cluster.endpoint
    }
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
