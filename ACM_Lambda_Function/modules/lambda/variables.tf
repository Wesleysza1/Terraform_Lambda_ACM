variable "acm_lambda_role_arn" {
  description = "ARN of ACM Lambda Role"
  type        = string
}

variable "coordinator_lambda_role_arn" {
  description = "ARN of Coordinator Lambda Role"
  type        = string
}

variable "acm_function_name" {
  type        = string
  description = "Name of ACM Lambda Function"
}

variable "coordinator_function_name" {
  type        = string
  description = "Name of Coordinator Lambda Function"
}