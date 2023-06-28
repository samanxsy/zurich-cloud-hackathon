########################################################
################### S 3 B u c k e t ####################

resource "aws_s3_bucket" "cloud_hackathon_bucket" {
    bucket = "cloud-hackathon-bucket"
    acl = "private"

    # Versioning & MFA delete
    versioning {
      enabled = true
      mfa_delete = true
    }

    # Server side logging config
    logging {
        target_bucket = "statebucketx"
        target_prefix = "cloud-hackathon/"
    }

    # Trigger config
    event {
        event_name = "s3:ObjectCreated:Put"
        lambda_function_arn = var.lambda_function_arn
        filter_prefix = "uploads/"
    }
}
