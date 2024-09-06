variable "acm_function_name" {
  type        = string
  description = "Name of ACM Lambda Function"
}

variable "coordinator_function_name" {
  type        = string
  description = "Name of Coordinator Lambda Function"
}

variable "to_notify" {
  type = list(string)
  description = "List of emails to be notified"
}