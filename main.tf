# Configure the AWS provider
provider "aws" {
  region = "ap-south-1"  # Replace with your desired region
}

# Create an SNS topic
resource "aws_sns_topic" "my_topic" {
  name = "my-topic"  # Replace with your desired topic name
}

# Create an SQS queue
resource "aws_sqs_queue" "my_queue" {
  name = "my-queue"  # Replace with your desired queue name
}

# Configure SNS to publish to SQS
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.my_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.my_lambda.arn
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach an IAM policy to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Create the Lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my-lambda"  # Replace with your desired function name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"  # Replace with your Lambda function handler
  runtime          = "nodejs14.x"  # Replace with your desired runtime
  timeout          = 10  # Replace with your desired timeout value
  memory_size      = 128  # Replace with your desired memory size
  publish          = true  # Set to false if you don't want to publish a new version
  source_code_hash = filebase64sha256("lambda_function.py")  # Replace with your Lambda deployment package filename

  # Specify your Lambda function's source code
  filename = "lambda_function.py"  # Replace with your Lambda deployment package filename
}
