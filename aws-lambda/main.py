#!/usr/bin/python3

# Lambda function for NUWE Zurich Cloud Hackathon
# Author: Saman Saybani

import json
import boto3

def lambda_handler(event, context):
    ''' Lambda Function to automate data insert into DynamoDB '''

    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]

    s3 = boto3.client('s3')
    response = s3.get_object(Bucket=bucket, Key=key)
    body = response["Body"].read().decode('utf-8')

    client_data = json.loads(body)

    # Extracting Client Data
    for info in client_data:    
        client_id = info["id"]
        client_name = info["name"]
        client_surname = info["surname"]
        client_birthdate = info["birthdate"]
        client_address = info["address"]

        # Car attributes
        client_car_make = info["car"]["make"]
        client_car_model = info["car"]["model"]
        client_car_year = info["car"]["year"]
        client_car_color = info["car"]["color"]
        client_car_plate = info["car"]["plate"]
        client_car_mileage = info["car"]["mileage"]
        client_car_fuelType = info["car"]["fuelType"]
        client_car_transmission = info["car"]["transmission"]

        # Fee
        fee = info["fee"]

        # Preparing for data for dynamoDB
        item = {
            "id": client_id,
            "name": client_name,
            "surname": client_surname,
            "birthdate": client_birthdate,
            "address": client_address,
            "car": {
                "make": client_car_make,
                "model": client_car_model,
                "year": client_car_year,
                "color": client_car_color,
                "plate": client_car_plate,
                "mileage": client_car_mileage,
                "fuelType": client_car_fuelType,
                "transmission": client_car_transmission
            },
            "fee": fee      
        }

        # dynamoDB
        dynamodb = boto3.resource("dynamodb")
        table = dynamodb.Table("cloud-hackathon-table")
        # Inserting into dynamoDB
        table.put_item(Item=item)

    return {
        "statusCode": 200,
        "body": "Data successfully inserted into DynamoDB"
    }
