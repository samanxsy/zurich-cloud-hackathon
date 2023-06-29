########################################################
################### D y n a m o D B ####################

# Customer Managed Key
resource "aws_kms_key" "cloud_hackathon_key" {
    description = "Customer Managed Key"
    deletion_window_in_days = 30
    enable_key_rotation = true
}

# DynamoDB Table
resource "aws_dynamodb_table" "cloud_hackathon_table" {
    name = "cloud-hackathon-table"
    billing_mode = "PAY_PER_REQUEST"
    deletion_protection_enabled = false # Set to true for prod
    hash_key = "id"


    point_in_time_recovery {
      enabled = true
    }

    server_side_encryption {
      enabled = true
      kms_key_arn = aws_kms_key.cloud_hackathon_key.arn
    }

    attribute {
        name = "id"
        type = "S"
    }

    tags = {
        Name = "cloud-hackathon-DB-table"
        Environment = "Hackathon"
    }
}
