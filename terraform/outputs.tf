# Outputs for debugging and cross-referencing
output "sqs_queue_url" {
  value = aws_sqs_queue.dead_letter_queue.url
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.dead_letter_queue.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dead_letter_table.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.dead_letter_table.arn
}

output "lambda_arn" {
  value = module.lambda.lambda_arn
}

output "lambda_log_group_name" {
  value = module.lambda.lambda_log_group_name
}

output "eventbridge_event_rule" {
  value = module.lambda.eventbridge_event_rule
}