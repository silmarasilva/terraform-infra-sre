# Configure the AWS Provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.38.0"
    }
  }
}
provider "aws" {
  # Configuration options
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "techtalent"
}

