# ...
#
# Description:
# @TODO
#
# AWS Documentation:
# @TODO
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_notification

resource "aws_autoscaling_notification" "default" {
    group_names = [
        aws_eks_node_group.default.resources[0].autoscaling_groups[0].name
    ]

    notifications = [
        "autoscaling:EC2_INSTANCE_LAUNCH",
        "autoscaling:EC2_INSTANCE_TERMINATE",
        "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
        "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    ]

    # Amazon Simple Notification Service (SNS)
    topic_arn = var.sns_topics.auto_scaling_notifications.arn

    #depends_on = [ var.sns_topics.auto_scaling_notifications ]
}
