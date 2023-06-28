########################################################
######## T e r r a f o r m M a i n M o d u l e #########

# Terraform State
terraform {
  backend "s3" {
    bucket = "statebucketx"
    key    = "cloud-hackathon/terraform.tfstate"
    region = "us-east-1"
  }
}


# Provider
provider "aws" {
    region = "eu-central-1"
}


module "dynamoDB" {
    source = "./dynamoDB"
}

module "lambda" {
    source = "./lambda"
    aws_dynamodb_table = module.dynamoDB.aws_dynamodb_table
}

module "s3bucket" {
    source = "./s3bucket"
    lambda_function_arn = module.lambda.lambda_function_arn
}
