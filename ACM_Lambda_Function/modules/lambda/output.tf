output "coordinator_lambda_arn" {
  description = "ARN of Coordinator Lambda Function"
  value       = aws_lambda_function.coordinator.arn
}

output "acm_lambda_arn" {
  description = "ARN of ACM Lambda Function"
  value       = aws_lambda_function.get_acm.arn
}