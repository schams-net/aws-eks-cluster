# Terraform Central Control

#  Amazon Virtual Private Cloud (Amazon VPC)
module "aws_vpc" {
    source = "./modules/vpc"
    tags = var.tags
}

# Amazon Identity and Access Management (IAM)
module "aws_iam" {
    source = "./modules/iam"
    tags = var.tags
}

# Amazon RDS Aurora Serverless (MySQL/PostgreSQL)
module "aws_rds_cluster" {
    source = "./modules/rds-aurora-cluster"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets
    #availability_zones = ["ap-southeast-2a", "ap-southeast-2b"]
    tags = var.tags
}

# Amazon Elastic Kubernetes Service (EKS)
module "aws_eks" {
    source = "./modules/eks"
    vpc = module.aws_vpc.vpc
    subnets = module.aws_vpc.subnets
    eks_role = module.aws_iam.eks_role
    eks_role_policies = module.aws_iam.eks_role_policies
    eks_node_group_role = module.aws_iam.eks_node_group_role
    eks_node_group_role_policies = module.aws_iam.eks_node_group_role_policies
    tags = var.tags
}
