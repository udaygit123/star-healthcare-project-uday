terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key= "AKIA22GWLXBJKMHGMJOG"
  secret_key= "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"
}