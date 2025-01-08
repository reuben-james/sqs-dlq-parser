import boto3
import logging
import json
from datetime import datetime, timezone

# Initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize AWS clients
sqs = boto3.client('sqs')
dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    """
    AWS Lambda handler to process messages from an SQS queue and write them to DynamoDB.
    """
    logger.info("Lambda execution started")
    SQS_QUEUE_URL = event['SQS_QUEUE_URL']
    DYNAMO_TABLE_NAME = event['DYNAMO_TABLE_NAME']

    table = dynamodb.Table(DYNAMO_TABLE_NAME)
    processed_count = 0

    while True:
        # Receive messages from the SQS queue
        response = sqs.receive_message(
            QueueUrl=SQS_QUEUE_URL,
            MaxNumberOfMessages=10,
            WaitTimeSeconds=2,
            AttributeNames=['All']
        )

        messages = response.get('Messages', [])
        if not messages:
            logger.info(f"Finished processing all messages. Total processed: {processed_count}")
            break

        for message in messages:
            message_id = message['MessageId']

            # Check if the message has already been processed
            if is_message_already_processed(table, message_id):
                logger.info(f"Message {message_id} already processed. Skipping.")
                continue

            try:
                # Parse the message body
                body = json.loads(message['Body'])

                # Extract and transform data for DynamoDB
                extracted_data = {
                    "MessageId": message_id,
                    "EventTimestamp": body.get("event_timestamp", "N/A"),
                    "BucketName": body["bucket"]["name"],
                    "BucketKey": body["bucket"]["key"],
                    "ProcessedTimestamp": datetime.now(timezone.utc).isoformat(),
                }

                # Write the extracted data to DynamoDB
                table.put_item(Item=extracted_data)
                logger.info(f"Inserted message {message_id} into DynamoDB.")

                processed_count += 1

            except Exception as e:
                logger.info(f"Error processing message {message_id}: {e}")

def is_message_already_processed(table, message_id):
    """
    Checks if a message with the given MessageId exists in DynamoDB.

    :param table: DynamoDB table resource
    :param message_id: MessageId to check
    :return: True if the message exists, False otherwise
    """
    try:
        response = table.get_item(Key={'MessageId': message_id})
        return 'Item' in response
    except Exception as e:
        logger.exception(f"Error checking DynamoDB for message {message_id}: {e}")
        return False
