# Terraform Central Control

#  Amazon Virtual Private Cloud (Amazon VPC)
module "aws_vpc" {
    source = "./modules/vpc"
    tags = var.tags
}

# Amazon Identity and Access Management (IAM)
module "aws_iam" {
    source = "./modules/iam"
    rds_aurora_cluster = module.aws_rds_aurora.cluster
    eks_cluster = module.aws_eks.cluster
    s3_buckets = module.aws_s3.buckets
    secrets = module.aws_secrets_manager.secrets
    tags = var.tags
}

# Amazon RDS Aurora Serverless (MySQL/PostgreSQL)
module "aws_rds_aurora" {
    source = "./modules/rds-aurora"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets.private
    tags = var.tags
}

# AWS Secrets Manager
module "aws_secrets_manager" {
    source = "./modules/secrets-manager"
    rds_aurora_cluster = module.aws_rds_aurora.cluster
    s3_buckets = module.aws_s3.buckets
    redis_cluster = module.aws_elasticache.redis_cluster
    ses_notifications_endpoint = var.ses_notifications_endpoint
    tags = var.tags
}

# Amazon Elastic Kubernetes Service (EKS)
module "aws_eks" {
    source = "./modules/eks"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets.private
    iam_roles = module.aws_iam.roles
    eks_role_policies = module.aws_iam.eks_role_policies
    eks_node_group_role_policies = module.aws_iam.eks_node_group_role_policies
    sns_topics = module.aws_sns.topics
    cloudwatch_log_groups = module.aws_cloudwatch.log_groups
    tags = var.tags
}

# Amazon Simple Notification Service (SNS)
module "aws_sns" {
    source = "./modules/sns"
    ses_notifications_basic_auth = module.aws_secrets_manager.ses_notifications_basic_auth
    ses_notifications_endpoint = var.ses_notifications_endpoint
    tags = var.tags
}

# Amazon CloudWatch
module "aws_cloudwatch" {
    source = "./modules/cloudwatch"
    tags = var.tags
}

# Amazon ElastiCache for Redis
module "aws_elasticache" {
    source = "./modules/elasticache"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets.private
    cloudwatch_log_groups = module.aws_cloudwatch.log_groups
    sns_topics = module.aws_sns.topics
    tags = var.tags
}

# Helm charts installer
module "helm_charts" {
    source = "./modules/helm"
    eks_cluster = module.aws_eks.cluster
    tags = var.tags
}

# Kubernetes-specific resources and data sources
module "kubernetes" {
    source = "./modules/kubernetes"
    tags = var.tags
}

# Amazon CloudFront
module "aws_cloudfront" {
    source = "./modules/cloudfront"
    origins = {
        "load_balancer" = "default.example.com"
        "s3_media" = module.aws_s3.buckets.media.bucket_regional_domain_name
    }
    tags = var.tags
}

# Amazon S3
module "aws_s3" {
    source = "./modules/s3"
    cloudfront_distribution = module.aws_cloudfront.distribution
    random_identifier = random_id.identifier
    tags = var.tags
}

# Amazon Simple Email Service (SES)
module "aws_ses" {
    source = "./modules/ses"
    sns_topics = module.aws_sns.topics
    #random_identifier = random_id.identifier
    tags = var.tags
}