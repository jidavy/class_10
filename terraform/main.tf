# placeholder for terraform
terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "nginx_node" {
  ami                    = "ami-0059ac4c4e115926e"   # the nginx AMI you built
  instance_type          = "t3.micro"
  subnet_id              = "subnet-07d8201ba3ac978fb"
  vpc_security_group_ids = ["sg-0d8c51c096cf3e144"]
  key_name               = "dev_key"

  tags = {
    Name = "terraform-nginx-node"
  }
}
