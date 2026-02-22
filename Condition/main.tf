terraform {
required_version = ">=1.7.0"
required_providers {
  aws = {
    source = "hashicorp/aws"
    version = ">=5.0"
  }
}
}
provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "second" {
  ami = var.ami_id
  instance_type = var.instance_type == "t3" ? "t3.micro" :: "t2.micro" 
  key_name = var.key_name
  subnet_id = var.subnet_id
  security_group_ids = [var.security_group_id]
tags ={
  Name = "Terraform"
}
}
