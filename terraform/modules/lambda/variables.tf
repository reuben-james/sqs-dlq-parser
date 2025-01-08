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

variable "environment_variables" {
  description = "Environment-specific variables for the Lambda function"
  type        = map(string)
}

variable "lambda_policy_statements" {
  description = "IAM policy statements for Lambda"
  type = list(object({
    Action   = list(string)
    Effect   = string
    Resource = list(string)
  }))
}

variable "schedule_expression" {
  description = "Cron or rate expression for triggering the Lambda"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  default     = 30
  type        = number
}