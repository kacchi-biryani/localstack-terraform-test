import os
import boto3

try:
    sqs_client = boto3.client(
        'sqs',
        region_name="eu-central-1",
        endpoint_url="http://localhost:4566/000000000000/justTrack-staging-sqs",
        use_ssl=os.environ['USE_SSL'] == '1',
        verify=False,
        aws_access_key_id="123",
        aws_secret_access_key="qwe")
except Exception as e:
    print(e)
    
queue_url = sqs_client.get_queue_url('http://localhost:4566/000000000000/justTrack-staging-sqs')

try:
    # Receive message from SQS queue
    response = sqs_client.receive_message(
        QueueUrl=queue_url,
        AttributeNames=[
            'SentTimestamp'
        ],
        MaxNumberOfMessages=1,
        MessageAttributeNames=[
            'All'
        ],
        VisibilityTimeout=0,
        WaitTimeSeconds=0
    )

    message = response['Messages'][0]
    receipt_handle = message['ReceiptHandle']

    # Delete received message from queue
    sqs_client.delete_message(
        QueueUrl=queue_url,
        ReceiptHandle=receipt_handle
    )
    print('Received message: %s' % message)

except Exception as e:
    print(e)