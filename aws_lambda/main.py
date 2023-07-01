#!/usr/bin/python3

# Lambda function for NUWE Zurich Cloud Hackathon
# Author: Saman Saybani

import os
import json
import boto3


def lambda_handler(event, context):
    ''' This Lambda Function gets triggered upon uploading JSON in S3 bucket,
    and automatically parse, and then inserts the data into DynamoDB '''

    # Retrieving Bucket name and the Object Key
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    object_key = event['Records'][0]['s3']['object']['key']

    # Retrieving content of the object from S3
    s3_client = boto3.client('s3')
    response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
    content = response['Body'].read().decode('utf-8')

    client_data = json.loads(content)

    # Extracting Client Data from uploaded JSON in the S3 bucket
    try:
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

            # Preparing data for dynamoDB insertion
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
            # Environment Variable declared in Terraform lambda module
            table = dynamodb.Table(os.environ["DYNAMODB_TABLE"])
            # Putting data into dynamoDB
            table.put_item(Item=item)

        # Success
        send_notification("New Client Data has been successfully uploaded to DynamoDB")
        return {
            "statusCode": 200,
            "body": "Data successfully inserted into DynamoDB"
        }

    # Potential Key Error
    except KeyError:
        send_notification("Error: Client data upload Faild. Please check the uploaded `.json` file and make sure all the data are available")
        return {
            "statusCode": 400,
            "body": "some client data is missing"
        }


def send_notification(message):
    ''' Send notification using Amazon SNS '''
    sns = boto3.client("sns")
    topic_arn = os.environ["SNS_TOPIC_ARN"]

    # Publish the messages
    sns.publish(TopicArn=topic_arn, Message=message)
