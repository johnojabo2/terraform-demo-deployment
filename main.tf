resource "aws_iam_policy" "Mini" {
    name = "S3boss"
    tags = {
        Description = "Just an s3 policy"
    }
    policy = file("s3-full-policy.json")
}

resource "aws_iam_policy" "Dyn" {
    name = "DynamoBigi"
    tags = {
        Description = "Just an DB policy"
    }
    policy = file("dynam0-db-full-policy.json")
}

resource "aws_iam_policy" "EC2" {
    name = "Ec2fullacess"
    tags = {
        Description = "Just an Ec2 policy"
    }
    policy = file("ec2-full-policy.json")
}


resource "aws_s3_bucket" "Mini" {
  bucket = "cloud-crusaders-devtestbucket"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_dynamodb_table" "example_table" {
  name           = "mytesttable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  tags = {
    Environment = "production"
  }

  replica {
    region_name = "eu-north-1"
  }

  server_side_encryption {
    enabled = true
  }

  # Enable autoscaling with a target utilization of 70%
  # and configure read and write capacity to be automatically scaled between 5 and 10 units
  

  global_secondary_index {
    name = "my-dynamodb-table-gsi"
    hash_key = "userId"
    write_capacity = 5
    read_capacity = 5
    projection_type = "ALL"
  }
}


resource "aws_security_group" "web" {
  name_prefix = "websg"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_keypair" {
  key_name   = "my_keypair"
  public_key = file("~/.ssh/my_keypair.pub") 
}


resource "aws_instance" "web" {
  ami           = "ami-0df24e148fdb9f1d8" 
  instance_type = "t2.micro"
  key_name      = "my_keypair"
  vpc_security_group_ids = [aws_security_group.web.id]


  user_data = file("ec2-userdata.sh")
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
