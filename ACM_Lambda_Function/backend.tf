terraform {
  backend "s3" {
    bucket = ""
    key    = "acm-monitoring/terraform.tfstate"
    region = "us-east-1"
  }
}