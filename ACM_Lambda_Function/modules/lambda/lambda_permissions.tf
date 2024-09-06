resource "aws_lambda_permission" "allow_shared" {
  statement_id  = "shared-services"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_acm.function_name
  principal = "arn:aws:iam::978025642619:root" #shared-services account
}