# Cloud Hackathon Project
NUWE Zurich cloud hackathon

This project is created as part of the NUWE Zurich Cloud Hackathon with the objective of automating the sales department process of adding new customer data into the cloud database.


## Infrastructure Overview

The project consists of the following AWS resources:
- **Lambda Function**: The Lambda function, written in Python, is automatically triggered upon JSON file uploads to the S3bucket via S3 notification. Then, it will process the data received from the event and will insert it into DynamoDB table.  

- **S3 Bucket**: The S3 bucket serves as a storage location for the JSON files containing **client data**. It is responsible for triggering the lambda function upon each upload.

- **DynamoDB Table**: The DynamoDB table stores the client data processed by the Lambda function.

- **SNS Topic**: I added the SNS as an extra step, to give insights about the success or failure of the Data insertion process.

## Terraform Configurations
The infrastructure is provisioned using Terraform, and all of the configuration files are organized within the `terraform/` directory. Allowing a highly customizable and scalable Infrastructure as Code.  
The Terraform modules created by these configurations are:

- **lambda**: This module creates the lambda function and its associated IAM role. It also configures the necessary permissions for interaction with other AWS services and the path for taking the Function Code in a zip file.

- **S3bucket**: This module creates the S3 bucket and defines the event trigger for the Lambda function, whenever a **.json** file is uploaded. This module also creates the necessary resources to manage permission, logging, versioning, and ACL.

- **dynamoDB**: This module provisions the DynamoDB table for storing the JSON data. It defines the schema, the key, and serverside encryption if needed.

- **SNS**: This module creates the SNS topic for sending notifications to a list of subscriptions (Sales department) responsible for the data management, to notify them about the status of the upload.

## Deployment
The solution is ready to be deployed to an AWS infrastructure; if an AWS account with the necessary permissions is available. The solution has been successfully tested and meets the objectives outlined for this project.

## If I was earlier
Unfortunately, I was notified about the Hackathon a little bit late and could start working on it just a few days ago. However, If I had more time, I would've:  

1. Write comprehensive unittests for the lambda function Having mock tests would definitely make me feel better.  

2. Configure a CI/CD pipeline using GitHub Actions to run automated test cases, infrastructure vulnerability checks, and eventually automated Deployment  

3. Implement more granular access and permissions, and define precise access control policies with specific least privilege principles.

4. Implement proper logging and monitoring to utilize Amazon CloudWatch efficiently.

5. Definitely add more error handlings.


## Conclusion
Thank you so much for this interesting challenge and opportunity. I truly enjoyed the process and can not wait for the next phases! Thanks for reading me.  


## Author
Saman Saybani
