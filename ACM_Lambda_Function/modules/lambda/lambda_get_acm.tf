data "archive_file" "get_acm" {
  type        = "zip"
  source_file = "./modules/lambda/source_code/get_acm.py"
  output_path = "./modules/lambda/source_code/get_acm.zip"
}

resource "aws_lambda_function" "get_acm" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  description   = "Function used to list and notify about expiration of ACM Certificates."
  filename      = "./modules/lambda/source_code/get_acm.zip"
  function_name = var.acm_function_name
  role          = var.acm_lambda_role_arn
  handler       = "get_acm.lambda_handler"

  source_code_hash = data.archive_file.get_acm.output_base64sha256

  runtime     = "python3.12"
  memory_size = 128
  timeout     = 60

}