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

    point_in_time_recovery {
      enabled = true
    }

    server_side_encryption {
      enabled = true
      kms_key_arn = aws_kms_key.cloud_hackathon_key.arn
    }

    attribute {
        name = "id"
        type = "S" # String
    }

    attribute {
        name = "name"
        type = "S"
    }

    attribute {
        name = "surname"
        type = "S"
    }

    attribute {
        name = "birthdate"
        type = "S"
    }

    attribute {
        name = "address"
        type = "S"
    }

    attribute {
        name = "car"
        type = "M"  # Map
    }

    attribute {
        name = "fee"
        type = "N"  # Integer
    }

    # Car attributes
    attribute {
        name = "make"
        type = "S"
    }

    attribute {
        name = "model"
        type = "S"
    }

    attribute {
        name = "year"
        type = "N"
    }

    attribute {
        name = "color"
        type = "S"
    }

    attribute {
        name = "plate"
        type = "S"
    }

    attribute {
        name = "mileage"
        type = "N"
    }

    attribute {
        name = "fuelType"
        type = "S"
    }

    attribute {
        name = "transmission"
        type = "S"
    }

    # Primary Key
    key {
        name = "id"
        type = "HASH"
    }
}
