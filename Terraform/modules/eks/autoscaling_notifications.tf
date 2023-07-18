# Publish auto-scaling Events to Amazon SNS
#
# Description:
# Publish notifications through Amazon SNS topics. Each of the notifications represents an event that
# is triggered by auto-scaling.
#
# AWS Documentation:
# https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-sns-notifications.html
# https://docs.aws.amazon.com/sns/latest/dg/welcome.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_notification

resource "aws_autoscaling_notification" "default" {

    # List of auto-scaling group names
    group_names = [
        aws_eks_node_group.default.resources[0].autoscaling_groups[0].name
    ]

    # List of auto-scaling events that should be published as notifications
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
