##########################################################
################### A W S L a m b d a ####################

# Lambda IAM role
resource "aws_iam_role" "cloud_hackathon_lambda_role" {
    name = "cloud-hackathon-lambda-role"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Policy attachments
resource "aws_iam_policy_attachment" "cloud_hackathon_lambda_role_attachment" {
    role = aws_iam_role.cloud_hackathon_lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

# Lambda Function
resource "aws_lambda_function" "cloud_hackathon_lambda" {
    function_name = "cloud-hackathon-lambda"
    role = aws_iam_role.cloud_hackathon_lambda_role.arn
    handler = "main.lambda_handler"
    runtime = "python3.10"
    timeout = 15
    memory_size = 128

    # Lambda code path
    filename = "path/lambda_function.zip"

    tracing_config {
      mode = "Active"
    }

    environment {
      variables = {
        DYNAMODB_TABLE = aws_dynamodb_table.cloud_hackathon_table.name
      }
    }
}
