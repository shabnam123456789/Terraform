terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default provider (e.g., us-east-1)
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}

# Second provider (e.g., us-west-2)
provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}
