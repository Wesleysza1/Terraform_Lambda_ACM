output "coordinator_lambda_arn" {
  description = "ARN of Coordinator Lambda Function"
  value       = module.lambda.coordinator_lambda_arn
}

output "acm_lambda_arn" {
  description = "ARN of ACM Lambda Function"
  value       = module.lambda.acm_lambda_arn
}

output "coordinator_lambda_role_arn" {
  description = "ARN of ACM Lambda Role"
  value       = module.iam.coordinator_lambda_role_arn
}
