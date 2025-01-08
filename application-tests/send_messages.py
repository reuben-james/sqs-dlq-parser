import boto3
import uuid
import random
import string
import json
from datetime import datetime, timezone

# AWS SQS Queue URL
QUEUE_URL = "https://sqs.eu-west-2.amazonaws.com/067848901868/test-dead-letter-queue"

# Example S3 bucket name
S3_BUCKET_NAME = "test-bucket"

# Region Name
REGION = "eu-west-2"

# Initialize SQS client
sqs = boto3.client("sqs", region_name=REGION)

def generate_random_filename(extension="txt"):
    """
    Generate a random filename with a given extension.
    """
    filename = "".join(random.choices(string.ascii_letters + string.digits, k=10))
    return f"{filename}.{extension}"

def send_test_message(queue_url, bucket_name):
    """
    Send a test message to the specified SQS queue.
    """
    # Generate message content
    message = {
        "event_timestamp": datetime.now(timezone.utc).isoformat(),
        "bucket": {
            "name": bucket_name,
            "key": generate_random_filename()
        }
    }

    # Send message to SQS
    response = sqs.send_message(
        QueueUrl=queue_url,
        MessageBody=json.dumps(message)
    )

    print(f"Message sent with ID: {response['MessageId']}")

if __name__ == "__main__":
    # Number of test messages to send
    NUM_MESSAGES = 50

    for _ in range(NUM_MESSAGES):
        send_test_message(QUEUE_URL, S3_BUCKET_NAME)
