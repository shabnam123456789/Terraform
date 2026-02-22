Absolutely! Let’s go step by step. In Terraform, variables let you make your configurations dynamic and reusable. There are different types of variables and different ways to pass values. I’ll explain everything with clear examples.

1️⃣ Types of Variables in Terraform

Terraform supports 5 main variable types:

Type	Description	Example Value
string	Single text value	"t2.micro"
number	Numeric value	3, 8080
bool	Boolean (true/false)	true
list	Ordered collection of same type	["t2.micro", "t3.micro"]
map	Key-value pairs with same value type	{Name="Terraform", Env="Dev"}
object	Structured collection with different types	{ami=string, type=string, port=number}
set	Unordered unique values	toset([1,2,2,3]) → [1,2,3]
2️⃣ Declaring Variables

Variables are usually declared in a file called variables.tf.

Example: variables.tf
variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"   # optional default
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable CloudWatch monitoring"
  default     = true
}

variable "allowed_ports" {
  type        = list(number)
  description = "Ports allowed in security group"
  default     = [22, 80, 443]
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default     = {
    Name = "Terraform"
    Env  = "Dev"
  }
}

variable "server_config" {
  type = object({
    ami           = string
    instance_type = string
    port          = number
  })
}
3️⃣ Passing Variables

Terraform supports multiple ways to pass variable values.

✅ 3.1 Using default in variables.tf
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

No need to pass anything in command line or tfvars

Uses "t2.micro" if nothing is provided

✅ 3.2 Using terraform.tfvars

Create terraform.tfvars:

ami_id        = "ami-0abc123456789"
instance_type = "t3.micro"
enable_monitoring = false
allowed_ports = [22, 80, 443]
tags = {
  Name = "MyApp"
  Env  = "Prod"
}
server_config = {
  ami           = "ami-0abc123456789"
  instance_type = "t3.micro"
  port          = 8080
}

Terraform automatically picks up terraform.tfvars when you run:

terraform plan
terraform apply
✅ 3.3 Using -var-file for different environments
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="prod.tfvars"

Allows multiple environment files like dev.tfvars and prod.tfvars

✅ 3.4 Passing variable via CLI -var
terraform apply -var="instance_type=t3.micro" -var="ami_id=ami-0abc123456789"

Good for one-off overrides

Less common for big projects

✅ 3.5 Using locals or computed variables

Sometimes you combine variables with expressions:

locals {
  final_instance_type = contains(["t2.micro", "t3.micro"], var.instance_type) ? var.instance_type : "t2.micro"
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = local.final_instance_type
}

Ensures the instance type is valid

Combines logic with variables

4️⃣ Using Variables in Resources
resource "aws_instance" "example" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  tags = var.tags
}

Use var.<variable_name> to access any variable

For maps: var.tags["Name"]

For objects: var.server_config.ami

5️⃣ Summary of Passing Types
Method	Example	When to Use
default	In variable declaration	Simple default values
terraform.tfvars	Auto-loaded by Terraform	Main environment file
-var-file	terraform apply -var-file="dev.tfvars"	Multiple environments
-var	terraform apply -var="ami_id=..."	Quick override on command line
locals	Derived values from variables	Computed/conditional values

💡 Best Practices

Use terraform.tfvars for main values

Use -var-file for different environments (dev/prod/staging)

Use locals or ternary logic to enforce defaults or validation

Avoid hardcoding values in main.tf

If you want, I can make a full working AWS EC2 + Security Group Terraform project demonstrating:

All variable types (string, bool, list, map, object)

Passing via .tfvars and CLI

Conditional logic with contains() and toset()



Ah! Yes — thanks for pointing that out! Let me explain how -out= works with Terraform variables and plans, so it fits with everything we just discussed.

1️⃣ What -out= Does

When you run terraform plan, you can save the execution plan to a file using -out=<filename>

Example:

terraform plan -out=salma -var-file="dev.tfvars"

This creates a binary plan file called salma

It does not apply anything yet

Ensures that when you apply, you apply exactly this plan

2️⃣ Apply the Saved Plan
terraform apply salma

Terraform uses the saved plan instead of recalculating

Prevents accidental changes if someone modifies the code after planning

3️⃣ Using Variables with -out=

You can combine -out= with variable files or CLI variables:

terraform plan -out=prodplan -var-file="prod.tfvars" -var="enable_monitoring=true"

prodplan → saved plan

-var-file → load environment-specific values

-var → override single values from CLI

Then apply:

terraform apply prodplan

✅ This ensures the exact deployment as planned.

4️⃣ Full Example Workflow
terraform init                           # Initialize Terraform
terraform plan -out=devplan -var-file="dev.tfvars"   # Plan & save to file
terraform apply devplan                   # Apply the saved plan
terraform output                          # View outputs
5️⃣ Why -out= is useful

Review first – you can inspect the plan before applying

Safe automation – CI/CD pipelines use this to avoid surprises

Exact reproducibility – apply exactly what was planned

If you want, I can now make a full Terraform AWS EC2 project that uses:

variables.tf

dev.tfvars & prod.tfvars

-var-file and -out workflow

Conditional logic with contains() and toset()
==========================================
