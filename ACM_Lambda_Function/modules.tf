module "eventbridge" {
  source = "./modules/eventbridge"

  acm_lambda_arn            = module.lambda.acm_lambda_arn
  coordinator_lambda_arn    = module.lambda.coordinator_lambda_arn
  scheduler_role_arn        = module.iam.scheduler_role_arn
  acm_function_name         = var.acm_function_name
  coordinator_function_name = var.coordinator_function_name

}

module "iam" {
  source = "./modules/iam"

  acm_function_name         = var.acm_function_name
  coordinator_function_name = var.coordinator_function_name
}

module "lambda" {
  source = "./modules/lambda"

  acm_lambda_role_arn         = module.iam.acm_lambda_role_arn
  coordinator_lambda_role_arn = module.iam.coordinator_lambda_role_arn
  acm_function_name           = var.acm_function_name
  coordinator_function_name   = var.coordinator_function_name
}

module "sns" {
  source = "./modules/sns"

  acm_function_name         = var.acm_function_name
  coordinator_function_name = var.coordinator_function_name
  to_notify = var.to_notify
}