variable "instance_type" {

description = "true for production and false non production"
type = bool
default = false

}

variable "ami_id" {
description = "Enter your ami ID"
type = string

}

variable "key_name" {
description = "Enter you key value name"
type = string
}

variable "subnet_id" {
description = "Enter subnet ID"
type = string
}

