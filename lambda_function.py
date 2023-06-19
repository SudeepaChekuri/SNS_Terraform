import json

def lambda_handler(event, context):
    num1 = event['num1']
    num2 = event['num2']
    
    sum = num1 + num2
    
    response = {
        'statusCode': 200,
        'body': json.dumps({'result': sum})
    }
    
    return response
