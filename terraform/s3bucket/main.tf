########################################################
################### S 3 B u c k e t ####################

resource "aws_s3_bucket" "cloud_hackathon_bucket" {
    bucket = "cloud-hackathon-bucket"

    tags = {
        Name = "cloud-hackathon-bucket"
        Environment = "Hackathon"
    }
}

resource "aws_s3_bucket_ownership_controls" "cloud_hackathon_bucket_control" {
  bucket = aws_s3_bucket.cloud_hackathon_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "cloud_hackathon_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.cloud_hackathon_bucket_control]

  bucket = aws_s3_bucket.cloud_hackathon_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_logging" "cloud_hackathon_bucket_logging" {
    bucket = aws_s3_bucket.cloud_hackathon_bucket.id
    target_bucket = "statebucketx"
    target_prefix = "cloud-hackathon/"
}

# Versioning & MFA Delete
resource "aws_s3_bucket_versioning" "cloud_hackathon_bucket_versioning" {
    bucket = aws_s3_bucket.cloud_hackathon_bucket.id

    versioning_configuration {
      status = "Enabled"
      mfa_delete = "Enabled"
    }
}

resource "aws_s3_bucket_notification" "cloud_hackathon_bucket_notification" {
    bucket = aws_s3_bucket.cloud_hackathon_bucket.id

    # Trigger config
    lambda_function {
        lambda_function_arn = var.lambda_function_arn
        events              = ["s3:ObjectCreated:Put"]
        filter_prefix       = "uploads/"
    }
}
