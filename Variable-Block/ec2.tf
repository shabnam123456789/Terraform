provider "aws" {

region = "eu-north-1"

}


resource "aws_instance" "test-server" {

ami = var.ami_id
instance_type = var.instance_type
key_name = var.key_name
subnet_id = var.subnet_id
vpc_security_group_ids = [var.security_group_id]

tags = {

Name = var.instance_name

}
}
