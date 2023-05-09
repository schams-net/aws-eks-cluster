# Terraform Central Control

#  Amazon Virtual Private Cloud (Amazon VPC)
module "aws_vpc" {
    source = "./modules/vpc"
    tags = var.tags
}

# Amazon Identity and Access Management (IAM)
module "aws_iam" {
    source = "./modules/iam"
    region = var.region
    rds_aurora_instances = module.aws_rds_cluster.rds_aurora_instances
    tags = var.tags
}

# Amazon RDS Aurora Serverless (MySQL/PostgreSQL)
module "aws_rds_cluster" {
    source = "./modules/rds-aurora-cluster"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets
    tags = var.tags
}

# AWS Secrets Manager
module "aws_secrets_manager" {
    source = "./modules/secrets-manager"
    rds_aurora_cluster = module.aws_rds_cluster.rds_aurora_cluster
    tags = var.tags
}

# Amazon Elastic Kubernetes Service (EKS)
module "aws_eks" {
    source = "./modules/eks"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets
    iam_roles = module.aws_iam.roles
    eks_role_policies = module.aws_iam.eks_role_policies
    eks_node_group_role_policies = module.aws_iam.eks_node_group_role_policies
    sns_topic_autoscaling_notification = module.aws_sns.auto_scaling_notifications
    tags = var.tags
}

# Amazon Simple Notification Service (SNS)
module "aws_sns" {
    source = "./modules/sns"
    tags = var.tags
}
