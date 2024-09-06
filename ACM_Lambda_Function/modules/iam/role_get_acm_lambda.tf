data "aws_iam_policy_document" "acm" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "acm_lambda" {
  name               = "${var.acm_function_name}-Role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.acm.json
}

resource "aws_iam_role_policy_attachment" "acm" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ])

  role       = aws_iam_role.acm_lambda.name
  policy_arn = each.key
}