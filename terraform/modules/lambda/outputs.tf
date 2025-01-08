output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_log_group_name" {
  value = aws_cloudwatch_log_group.lambda_log_group.name
}

output "eventbridge_event_rule" {
  value = aws_cloudwatch_event_rule.lambda_schedule.name
}
