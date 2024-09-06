output "acm_lambda_role_arn" {
  description = "ARN of ACM Lambda Role"
  value       = aws_iam_role.acm_lambda.arn
}

output "coordinator_lambda_role_arn" {
  description = "ARN of ACM Lambda Role"
  value       = aws_iam_role.coordinator.arn
}

output "scheduler_role_arn" {
  description = "ARN of Scheduler Role"
  value       = aws_iam_role.scheduler.arn
}