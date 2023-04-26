# Autoscaling Group (ASG) Tag
#
# Description:
# This resource manages an individual Autoscaling Group (ASG) tag. It should only be used in cases
# where ASGs are created outside Terraform (e.g., ASGs implicitly created by EKS Node Groups).
#
# The purpose of this resource is to assign tags to the EC2 instances. An alternative method to
# achieve the same result is to configure a launch template.
#
# AWS Documentation:
# n/a
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag

resource "aws_autoscaling_group_tag" "tag_name" {    
    autoscaling_group_name = aws_eks_node_group.default.resources[0].autoscaling_groups[0].name
    tag {
        key = "Name"
        value = "[${var.tags.Name}] worker node"
        propagate_at_launch = true
    }
    depends_on = [
        aws_eks_node_group.default
    ]
}

resource "aws_autoscaling_group_tag" "tag_billing_id" {
    autoscaling_group_name = aws_eks_node_group.default.resources[0].autoscaling_groups[0].name
    tag {
        key = "billing-id"
        value = var.tags.billing-id
        propagate_at_launch = true
    }
    depends_on = [
        aws_eks_node_group.default
    ]
}
