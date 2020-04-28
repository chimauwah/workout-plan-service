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
    "App" = "Workout Plan Service"
    "Provisioner" = "Terraform"
    "ManagedBy" = "ChimaChris"
  }
}

# Lambda variables
variable "lambda_timeout_seconds" {
  default = 15
}
variable "lambda_memory_size" {
  default = 128
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

# vpc variables
variable "subnet_ids" {
  type = list
  default = [
    "subnet-e62cd19d",
    "subnet-0c839246",
    "subnet-c9c960a0"]
}
variable "security_group_ids" {
  type = list
  default = [
    "sg-bb308cd2"]
}