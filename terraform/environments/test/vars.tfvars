environment                = "test"
function_name              = "dead-letter-processor"
lambda_package             = "lambda_function.zip"
lambda_timeout             = 30
lambda_schedule_expression = "rate(1 minute)"
dynamodb_table_name        = "DeadLetterMessages"
