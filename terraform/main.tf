# Create the SQS Dead Letter Queue
resource "aws_sqs_queue" "dead_letter_queue" {
  name = "${var.environment}-dead-letter-queue"
}

# Create the DynamoDB Table
resource "aws_dynamodb_table" "dead_letter_table" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "MessageId"
    type = "S"
  }

  hash_key = "MessageId"
}

# Deploy the Lambda using the reusable module
module "lambda" {
  source = "./modules/lambda" # Path to the Lambda module

  function_name  = "${var.environment}-${var.function_name}"
  lambda_package = var.lambda_package
  lambda_timeout = var.lambda_timeout
  environment_variables = {
    SQS_QUEUE_URL     = aws_sqs_queue.dead_letter_queue.url
    DYNAMO_TABLE_NAME = aws_dynamodb_table.dead_letter_table.name
  }
  lambda_policy_statements = [
    {
      Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes", "sqs:GetQueueUrl"]
      Effect   = "Allow"
      Resource = [aws_sqs_queue.dead_letter_queue.arn]
    },
    {
      Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
      Effect   = "Allow"
      Resource = [aws_dynamodb_table.dead_letter_table.arn]
    },
    {
      Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.environment}-${var.function_name}:*"]
    }
  ]
  schedule_expression = var.lambda_schedule_expression
  log_retention_days  = var.lambda_log_retention_days
}
