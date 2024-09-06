data "aws_caller_identity" "current" {}

resource "aws_iam_role" "scheduler" {
  name = "EventBridgeScheduler-${var.coordinator_function_name}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "scheduler.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : "${data.aws_caller_identity.current.account_id}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "scheduler" {
  name = "lambda-policy-${var.coordinator_function_name}"
  role = aws_iam_role.scheduler.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : [
          "arn:aws:lambda:us-east-1:${data.aws_caller_identity.current.account_id}:function:${var.coordinator_function_name}:*",
          "arn:aws:lambda:us-east-1:${data.aws_caller_identity.current.account_id}:function:${var.coordinator_function_name}"
        ]
      }
    ]
  })
}