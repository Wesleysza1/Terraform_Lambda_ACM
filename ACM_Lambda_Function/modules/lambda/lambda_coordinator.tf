data "archive_file" "coordinator" {
  type        = "zip"
  source_file = "./modules/lambda/source_code/coordinator.py"
  output_path = "./modules/lambda/source_code/coordinator.zip"
}

resource "aws_lambda_function" "coordinator" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  description   = "Function used to list and notify about expiration of ACM Certificates."
  filename      = "./modules/lambda/source_code/coordinator.zip"
  function_name = var.coordinator_function_name
  role          = var.coordinator_lambda_role_arn
  handler       = "coordinator.lambda_handler"

  source_code_hash = data.archive_file.coordinator.output_base64sha256

  runtime     = "python3.12"
  memory_size = 128
  timeout     = 600

}