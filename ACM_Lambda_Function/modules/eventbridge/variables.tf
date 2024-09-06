variable "coordinator_lambda_arn" {
  type        = string
  description = "ARN of Coordinator Lambda Function"
}

variable "acm_lambda_arn" {
  type        = string
  description = "ARN of ACM Lambda Function"
}

variable "scheduler_role_arn" {
  type        = string
  description = "ARN of Scheduler Role"
}

variable "acm_function_name" {
  type        = string
  description = "Name of ACM Lambda Function"
}

variable "coordinator_function_name" {
  type        = string
  description = "Name of Coordinator Lambda Function"
}