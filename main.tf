terraform {
  required_version = "~> 1.5.1"

  backend "s3" {
    key = "main.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
