terraform {
  required_version = "~> 1.2.0"

  backend "s3" {
    key = "main.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
