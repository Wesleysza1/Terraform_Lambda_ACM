resource "aws_sns_topic" "acm" {
  name              = "SNS-${var.coordinator_function_name}"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "acm" {
  for_each = toset(var.to_notify)

  topic_arn = aws_sns_topic.acm.arn
  protocol  = "email"
  endpoint  = each.key
}