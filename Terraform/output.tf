# Output variables

output "cloudfront_endpoint" {
    sensitive = false
    value = module.aws_cloudfront.distribution.domain_name
}

output "cloudfront_token" {
    sensitive = false
    value = module.aws_cloudfront.http_header_token
}

output "rds_aurora_cluster_endpoint" {
    sensitive = false
    value = module.aws_rds_aurora.cluster.endpoint
}

output "eks_cluster_endpoint" {
    sensitive = false
    value = module.aws_eks.cluster.endpoint
}
