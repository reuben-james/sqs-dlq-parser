# Testing the SQS DLQ Processor

After deployment you can manually put messages onto the SQL DLQ using `send_messages.py`

To manually fire the lambda to run processing, under the `Test` tab, create a new event with the following Event JSON, then hit `Test`: 
```
{
  "SQS_QUEUE_URL": "<SQS_QUEUE_URL>",
  "DYNAMO_TABLE_NAME": "<DYNAMO_TABLE_NAME>"
}
```

You can get these values from the outputs of the terraform deployment. 

Confirm the EventBridge Rule is enabled:
```
aws events describe-rule --name "<EVENTBRIDGE_EVENT_NAME>"
```
