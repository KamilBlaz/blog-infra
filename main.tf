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


#resource "cloudflare_account" "this" {
#  name              = "Blusik999@outlook.com"
#  type              = "standard"
#  enforce_twofactor = true
#}

## TO DO import infrastructure

#data "cloudflare_accounts" "this" {
#  name = "devkblaz"
#}
#
#resource "cloudflare_zone" "example" {
#  account_id = cloudflare_accounts.this.accounts.0.id
#  zone       = "devkblaz.com"
#}
#
#resource "cloudflare_record" "this" {
#  zone_id = var.cloudflare_zone_id
#  name    = "terraform"
#  value   = "192.0.2.1"
#  type    = "A"
#  ttl     = 3600
#}