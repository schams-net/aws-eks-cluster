# Output variables

output "topics" {
    value = {
        auto_scaling_notifications = aws_sns_topic.auto_scaling_notifications
        redis_notifications = aws_sns_topic.redis_notifications
    }
}
