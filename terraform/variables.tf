variable "aws_region" {
  description = "Name of the AWS Region you're deploying to."
  type        = string
}

variable "environment" {
  description = "Name of the Environment. Used in other variable to distinguish this environment."
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB Table"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_package" {
  description = "Path to the Lambda deployment package"
  type        = string
}

variable "lambda_timeout" {
  description = "Set the lambda timeout in seconds"
  default     = 3
  type        = number
}

variable "lambda_schedule_expression" {
  description = "Cron or rate expression for triggering the Lambda"
  type        = string
}

variable "lambda_log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  default     = 30
  type        = number
}
