# Zurich Cloud Hackathon - FINALIST PROJECT - JUNE 2023
**Zurich cloud hackathon, Powered by NUWE**  
This project was created for the Zurich Cloud Hackathon pre-selection phase and made it to the on-site final in Barcelona.  

**See The Final Project**: [Zurich-Cloud-Hackathon-Final-Barcelona](https://github.com/samanxsy/zurich-hackathon-final)

---
**SOLUTION SECTION**
## objective
automating the sales department process of adding new customer data into the cloud database. 

## Infrastructure Overview
The project consists of the following AWS resources:
- **Lambda Function**: The Lambda function, written in Python, is automatically triggered upon JSON file uploads to the S3bucket via S3 notification. Then, it will process the data received from the event and will insert it into the DynamoDB table.  

- **S3 Bucket**: The S3 bucket serves as a storage location for the JSON files containing **client data**. It is responsible for triggering the lambda function upon each upload.

- **DynamoDB Table**: The DynamoDB table stores the client data processed by the Lambda function.

- **SNS Topic**: I added the SNS as an extra step, to give insights about the success or failure of the Data insertion process.

## Terraform Configurations
The infrastructure is provisioned using Terraform, and all of the configuration files are organized within the `terraform/` directory. Allowing a highly customizable and scalable Infrastructure as Code. The Terraform backend configuration is set to utilize a remote state in a dedicated S3 bucket.  

The Terraform modules created by these configurations are:  

- **lambda**: This module creates the lambda function and its associated IAM role. It also configures the necessary permissions for interaction with other AWS services and the path for taking the Function Code in a zip file.

- **S3bucket**: This module creates the S3 bucket and defines the event trigger for the Lambda function, whenever a **.json** file is uploaded. This module also creates the necessary resources to manage permission, logging, versioning, and ACL.

- **dynamoDB**: This module provisions the DynamoDB table for storing the JSON data. It defines the schema, the key, and serverside encryption if needed.

- **SNS**: This module creates the SNS topic for sending notifications to a list of subscriptions (Sales department) responsible for data management, to notify them about the status of the upload.

## Deployment
The solution is ready to be deployed to an AWS infrastructure; if an AWS account with the necessary permissions is available. The solution has been successfully tested and meets the objectives outlined for this project.

## Conclusion
Thank you so much for this interesting challenge and opportunity. I truly enjoyed the process and can not wait for the next phases! Thanks for reading me.  


## Author
Saman Saybani
