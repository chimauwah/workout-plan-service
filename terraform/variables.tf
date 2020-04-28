# generic variables
variable "region" {
  default = "us-east-2"
}
variable "project_version" {
  default = "0.0.1-SNAPSHOT"
}

variable "common_tags" {
  type = map
  default = {
    "BusinessUnit" = "ChimaChris"
    "App"          = "Workout Plan Service"
    "Provisioner"  = "Terraform"
    "ManagedBy"    = "ChimaChris"
  }
}

# Lambda variables
variable "lambda_timeout_seconds" {
  default = 30
}
variable "lambda_memory_size" {
  default = 256
}
variable "lambda_zip_location" {
  default = "../target/workout-plan-service-0.0.1-SNAPSHOT.zip"
}
variable "reserved_concurrent_executions" {
  default = 1
}
variable "runtime" {
  default = "go1.x"
}

# database variables
variable "db_driver_name" {}
variable "db_user_name" {}
variable "db_user_password" {}
variable "db_host" {}
variable "db_port" {}
variable "db_schema" {}