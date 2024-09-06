resource "aws_scheduler_schedule" "lambda_schedule" {
  name       = "Schedule-${var.coordinator_function_name}"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(0 0 10 * ? *)"
  schedule_expression_timezone = "America/Sao_Paulo"

  target {
    arn      = var.coordinator_lambda_arn
    role_arn = var.scheduler_role_arn
  }
}