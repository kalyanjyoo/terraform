# Terraform Block
terraform {
  #required provider requirments
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"

    }
  }
}
# Provider Block
provider "aws" {
  region = "ap-south-1"
}
