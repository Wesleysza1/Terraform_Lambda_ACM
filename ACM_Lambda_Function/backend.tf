terraform {
  backend "s3" {
    bucket = ""
    key    = "acm-monitoring/terraform.tfstate"
    dynamodb_table = "terrafor-tfstate"
    region = "us-east-1"
  }
}