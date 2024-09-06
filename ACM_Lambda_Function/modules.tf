module "iam" {
  source = "./modules/iam"
  
  acm_function_name         = var.acm_function_name
}

module "lambda" {
  source = "./modules/lambda"

  acm_lambda_role_arn         = module.iam.acm_lambda_role_arn
  acm_function_name           = var.acm_function_name
}