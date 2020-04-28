provider "aws" {
  region = "${var.region}"
}

locals {
  lambda_function_name = "workout-plan-service"

}

# create IAM role that can invoke Lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Lambda functions
resource "aws_lambda_function" "workout_plan_service_lambda" {
  filename      = "${var.lambda_zip_location}"
  function_name = "${local.lambda_function_name}-2"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "${local.lambda_function_name}-${var.project_version}"

  timeout     = "${var.lambda_timeout_seconds}"
  memory_size = "${var.lambda_memory_size}"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  //source_code_hash = "${filebase64sha256("lambda_function_payload.zip")}"

  runtime = "${var.runtime}"

  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  tags = "${var.common_tags}"

  environment {
    variables = {
      DB_DRIVER_NAME   = "${var.db_driver_name}"
      DB_HOST          = "${var.db_host}"
      DB_PORT          = "${var.db_port}"
      DB_USER_NAME     = "${var.db_user_name}"
      DB_USER_PASSWORD = "${var.db_user_password}"
      DB_SCHEMA        = "${var.db_schema}"
    }
  }
}