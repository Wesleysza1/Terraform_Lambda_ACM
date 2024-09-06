# variables for provider
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where resources will be provisioned."
}

# variaveis lambda
variable "acm_function_name" {
  type        = string
  description = "Name of ACM Lambda Function"
  default     = "ACM-Certificates-Monitoring"
}

variable "coordinator_function_name" {
  type        = string
  description = "Name of Coordinator Lambda Function"
  default     = "ACM-Certificates-Monitoring-Coordinator"
}

variable "to_notify" {
  type = list(string)
  description = "List of emails to be notified"
  default = [     
    "teste@gmail.com",
    "wesley@gmail.com"
  ]
}