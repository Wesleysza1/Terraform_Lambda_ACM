data "aws_iam_policy_document" "coordinator" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "coordinator" {
  name               = "${var.coordinator_function_name}-Role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.coordinator.json
}

resource "aws_iam_role_policy_attachment" "coordinator" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ])

  role       = aws_iam_role.coordinator.name
  policy_arn = each.key
}