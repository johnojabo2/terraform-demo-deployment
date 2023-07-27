#!/bin/bash

# Install git
sudo yum update -y
sudo yum install -y git

# Clone the git repo
git clone https://github.com/aws-samples/aws-nodejs-sample.git
cd aws-nodejs-sample

# Install Node.js
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs

sudo amazon-linux-extras install -y awscli

# Install npm
sudo yum install -y npm

# Configure AWS CLI
aws configure set aws_access_key_id YourAccessKey
aws configure set aws_secret_access_key YourSecretKey
aws configure set default.region YourDefaultRegion
aws configure set default.output YourDefaultOutput



# Install AWS SDK and CLI

sudo npm install -y aws-sdk@2.x

# Run the Node.js file
 node sample.js
