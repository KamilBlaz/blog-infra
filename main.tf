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

data "cloudflare_zone" "zone" {
  name = "devkblaz.com"
}

# resource "cloudflare_pages_project" "this" {
#   name                   = "blog"
#   account_id            = var.cloudflare_account_id
#   production_branch     = "main"
#   deployment_configs {
#     production {
#       always_use_latest_compatibility_date = true
#       compatibility_date                   = "2023-01-01"
#       compatibility_flags                  = []
#       d1_databases                        = {}
#       durable_object_namespaces           = {}
#       environment_variables               = {}
#       kv_namespaces                      = {}
#       r2_buckets                         = {}
#     }
#   }
# }

# resource "cloudflare_record" "tunnel" {
#   zone_id = data.cloudflare_zone.zone.id
#   type    = "CNAME"
#   name    = "homelab-tunnel"
#   value   = "${cloudflare_tunnel.homelab.id}.cfargotunnel.com"
#   proxied = false
#   ttl     = 1 # Auto
# }

# resource "cloudflare_record" "this" {
#   zone_id = data.cloudflare_zone.zone.id
#   name    = "www"
#   type    = "CNAME"
#   value   = "xxxxx"
#   proxied = true
#   ttl     = 1  # Auto in Cloudflare is represented as TTL = 1
# }


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