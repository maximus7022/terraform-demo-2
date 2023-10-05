# project configuration
terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "tf-rmt-state-s3-bucket"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "dydb-terraform-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}
