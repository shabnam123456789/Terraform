variable "ami_id" {
  description = "This is the AMI ID for my instance"
  type        = string  # Corrected to string
}

variable "instance_type" {
  description = "This is the instance type for my instance"
  type        = string
}

variable "key_name" {
  description = "This is the key pair name for my instance"
  type        = string
}

variable "subnet_id" {
  description = "This is my subnet_id for my instance"
  type        = string  # Corrected to string
}

variable "security_group_id" {
  description = "This is the security group id for my instance"
  type        = string  # Corrected to string
}

variable "instance_name" {
  description = "This is the instance name for my instance"
  type        = string
}
