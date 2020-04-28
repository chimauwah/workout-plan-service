provider "aws" {
  region = var.region
}

locals {
  lambda_function_name = "workout-plan-service"

}

# create IAM role that can invoke Lambda
resource "aws_iam_role" "workout_plan_service_lambda_iam_role" {
  name = "workout_plan_service_lambda_iam_role"

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

resource "aws_iam_policy" "workout_plan_service_lambda_iam_policy" {
  name        = "workout_plan_service_lambda_iam_policy"
  description = "Policy allowing workout plan service Lambda access"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.workout_plan_service_lambda_iam_role.name
  policy_arn = aws_iam_policy.workout_plan_service_lambda_iam_policy.arn
}

# Lambda functions
resource "aws_lambda_function" "workout_plan_service_lambda" {
  filename      = var.lambda_zip_location
  function_name = local.lambda_function_name
  role          = aws_iam_role.workout_plan_service_lambda_iam_role.arn
  handler       = "${local.lambda_function_name}-${var.project_version}"

  timeout     = var.lambda_timeout_seconds
  memory_size = var.lambda_memory_size

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  source_code_hash = filebase64sha256(var.lambda_zip_location)

  runtime = var.runtime

  reserved_concurrent_executions = var.reserved_concurrent_executions

  tags = var.common_tags

  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  environment {
    variables = {
      DB_DRIVER_NAME   = var.db_driver_name
      DB_HOST          = var.db_host
      DB_PORT          = var.db_port
      DB_USER_NAME     = var.db_user_name
      DB_USER_PASSWORD = var.db_user_password
      DB_SCHEMA        = var.db_schema
    }
  }
}