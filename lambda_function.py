def lambda_handler(event, context):
    message = event['Records'][0]['Sns']['Message']
    print("Received SNS message:", message)

    # Perform any desired operations with the message

    return {
        'statusCode': 200,
        'body': 'SNS message processed successfully'
    }
