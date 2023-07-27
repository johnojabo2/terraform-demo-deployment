# AWS Infrastructure Deployment

This repository contains the Terraform configuration to deploy various AWS resources, including IAM policies, S3 bucket, DynamoDB table, EC2 instance, and security group. The Terraform configuration files are provided in this repository to streamline the provisioning and management of your AWS infrastructure.

## Prerequisites

Before using this Terraform configuration, ensure you have the following:

1. AWS CLI installed and configured with appropriate access credentials.
2. Terraform installed on your local machine.

## Configuration Overview

The Terraform configuration consists of the following resources:

### 1. IAM Policies

- **Mini** (`aws_iam_policy.Mini`): An IAM policy named "S3boss" with the contents from the "s3-full-policy.json" file.

- **Dyn** (`aws_iam_policy.Dyn`): An IAM policy named "DynamoBigi" with the contents from the "dynam0-db-full-policy.json" file.

- **EC2** (`aws_iam_policy.EC2`): An IAM policy named "Ec2fullacess" with the contents from the "ec2-full-policy.json" file.

### 2. S3 Bucket

- **Mini** (`aws_s3_bucket.Mini`): An S3 bucket named "cloud-crusaders-devtestbucket" with versioning enabled and server-side encryption using AES256.

### 3. DynamoDB Table

- **example_table** (`aws_dynamodb_table.example_table`): A DynamoDB table named "mytesttable" with PAY_PER_REQUEST billing mode, a hash key "userId," and global secondary index "my-dynamodb-table-gsi."

### 4. Security Group

- **web** (`aws_security_group.web`): A security group named "websg" with all traffic allowed (ingress and egress) from "0.0.0.0/0."

### 5. Key Pair

- **my_keypair** (`aws_key_pair.my_keypair`): An AWS key pair named "my_keypair" associated with the public key from "~/.ssh/my_keypair.pub".

### 6. EC2 Instance

- **web** (`aws_instance.web`): An EC2 instance using the AMI "ami-0df24e148fdb9f1d8", instance type "t2.micro," and associated with the "my_keypair" key pair. It is attached to the "websg" security group and runs the user data script from "ec2-userdata.sh."

## Usage

To deploy the AWS resources, follow these steps:

1. Clone this repository to your local machine.

2. Initialize Terraform in the repository directory:

   ```
   terraform init
   ```

3. Review the configuration in the Terraform files.

4. Apply the Terraform configuration to create the resources:

   ```
   terraform apply
   ```

   You will be prompted to confirm the changes before proceeding.

5. After the resources are created, Terraform will display the public IP address of the EC2 instance as an output.

## Clean Up

To clean up and destroy the AWS resources created by Terraform, run:

```
terraform destroy
```

You will be prompted to confirm the destruction of resources before proceeding.

**Note:** Be cautious when running the "terraform destroy" command as it will permanently delete the resources.

## Disclaimer

This Terraform configuration is intended for demonstration purposes and may not be suitable for production use without further customization and security considerations. Always review and adjust the configuration to meet your specific requirements before deploying resources in a production environment.

## License

This repository is licensed under the [MIT License](LICENSE.md).