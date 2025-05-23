terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  #shared_credentials_file = var.aws_local_creds_file
  profile = var.aws_local_profile
}

data "aws_caller_identity" "current" {}
