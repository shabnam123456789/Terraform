variable  "ami_id" {
type = string
description = "this is ami id"
default = "ami-09a9858973b288bdd"
}
variable "instance_type" {
type = string
description =" this si instance name"
default = "t2.micro"
}
variable "Key_name" {
type = string
description =" this is key name"
default = "simple-app"
}
variable "subnet_id" {
type = string
description =" this is subnet id"
default = "subnet-0a1e04b6049716bd"
}
variable "security-group_id" {
type = string
description =" this is subnet id"
default = "sg-020d1a7a3ad37a0b5"
}
