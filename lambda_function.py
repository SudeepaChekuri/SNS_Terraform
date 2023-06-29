import boto3

def lambda_handler(event, context):
    # Create a Boto3 client for the desired AWS service
    s3_client = boto3.client('s3')
    
    # Example: Upload a file to an S3 bucket
    bucket_name = 'my-bucket'
    key = 'hello.txt'
    content = 'Hello, world!'
    
    s3_client.put_object(Body=content, Bucket=bucket_name, Key=key)
    
    return {
        'statusCode': 200,
        'body': 'File uploaded successfully'
    }


#def lambda_handler(event, context):
 #   message = event['Records'][0]['Sns']['Message']
  #  print("Received SNS message:", message)

    # Perform any desired operations with the message

#    return {
 #       'statusCode': 200,
  #      'body': 'SNS message processed successfully'
   # }
