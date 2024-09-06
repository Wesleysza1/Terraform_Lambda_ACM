terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Iac = "Terraform"
    }
  }
}
