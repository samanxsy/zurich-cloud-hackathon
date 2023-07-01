###########################################################
#################### A m a z o n S N S ####################

resource "aws_sns_topic" "cloud_hackathon_topic" {
  name = "Client-DataUpload-Status"
}

resource "aws_sns_topic_subscription" "email_subscriptions" {
  count     = length(var.email_addresses)
  topic_arn = aws_sns_topic.cloud_hackathon_topic.arn
  protocol  = "email"
  endpoint  = var.email_addresses[count.index]
}
