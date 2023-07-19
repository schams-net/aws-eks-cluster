# Amazon RDS Aurora Serverless (MySQL or PostgreSQL)
#
# Description:
# Amazon Aurora Serverless is an on-demand, autoscaling configuration for Amazon Aurora.
# It automatically starts up, shuts down, and scales capacity up or down based on your
# application's needs. Amazon Aurora Serverless v2 scales instantly to hundreds of thousands
# of transactions in a fraction of a second. As it scales, it adjusts capacity in fine-grained
# increments to provide the right amount of database resources that the application needs.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster

resource "aws_rds_cluster" "default" {
    cluster_identifier = "${lower(var.tags.Name)}-aurora-cluster"

    # PostgreSQL
    #engine = "aurora-postgresql"
    #engine_version = "..."

    # MySQL
    engine = "aurora-mysql"
    engine_version = "8.0.mysql_aurora.3.03.0"

    engine_mode = "provisioned"

    # List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can
    # be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will
    # show as a difference requiring resource recreation next Terraform apply. The Terraform
    # documentation recommends specifying 3 AZs or using the lifecycle configuration block
    # ignore_changes argument if necessary. A maximum of 3 AZs can be configured.
    availability_zones = var.subnets[*].availability_zone

    lifecycle {
        ignore_changes = [ availability_zones ]
    }

    master_username = "dbadmin"
    manage_master_user_password = true
    #master_user_secret_kms_key_id = aws_kms_key.example.key_id

    iam_database_authentication_enabled = true

    # List of ARNs for the IAM roles to associate to the RDS Cluster.
    #iam_roles = [ ... ]

    # Name for an automatically created database on cluster creation
    database_name = replace(lower(var.tags.Name), "/[^a-z0-9]/", "")

    # If true, a final DB snapshot is created before the DB cluster is deleted.
    skip_final_snapshot = true

    serverlessv2_scaling_configuration {
        # The minimum capacity for an Aurora DB cluster in provisioned DB engine mode.
        # The minimum capacity must be lesser than or equal to the maximum capacity.
        # Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5.
        min_capacity = 0.5

        # The maximum capacity for an Aurora DB cluster.
        # Valid capacity values: same as above.
        max_capacity = 1.0
    }

    backup_retention_period = 1
    preferred_backup_window = "12:00-14:59"
    preferred_maintenance_window = "tue:15:00-tue:16:59"

    apply_immediately = true

    copy_tags_to_snapshot = true

    storage_encrypted = true
    #kms_key_id = var.kms_key_rds_aurora_arn

    db_subnet_group_name = aws_db_subnet_group.default.name
    vpc_security_group_ids = [ aws_security_group.rds.id ]
    #db_cluster_parameter_group_name = var.parameter_group.name

    tags = var.tags
}
