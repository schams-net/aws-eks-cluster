# Amazon IAM Policy
#
# Description:
# You manage access in AWS by creating policies and attaching them to IAM identities (users, groups
# of users, or roles) or AWS resources. A policy is an object in AWS that, when associated with an
# identity or resource, defines their permissions.
#
# AWS Documentation:
# https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment

# Policy for the Amazon Load Balancer
resource "aws_iam_policy" "aws_load_balancer" {
    name = "${var.tags.Name}-AwsLoadBalancer"
    path = "/"
    description = "Policy for the Amazon Amazon Load Balancer"
    policy = file("${path.module}/json/aws-load-balancer-policy.json")
    tags = merge(var.tags, {
        Name = "${var.tags.Name}-AwsLoadBalancer"
    })
}

# Attach the policy to the Node Group role
resource "aws_iam_role_policy_attachment" "aws_load_balancer" {
    policy_arn = aws_iam_policy.aws_load_balancer.arn
    role = aws_iam_role.eks_node_group.name
}
