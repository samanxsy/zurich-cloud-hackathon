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
    aws_s3_bucket_arn = module.s3bucket.aws_s3_bucket_arn
    aws_sns_topic_arn = module.sns.aws_sns_topic_arn
}

module "s3bucket" {
    source = "./s3bucket"
    lambda_function_arn = module.lambda.lambda_function_arn
}

module "sns" {
    source = "./sns"
}
