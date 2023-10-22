variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "bucket" {
  description = "S3 remote state bucket"
  type        = string
}

variable "dynamodb_table" {
  description = "Terraform lock table"
  type        = string
}

variable "encrypt" {
  description = "Determines if state should be encrypted at rest. This is required for tf backend."
  type        = bool
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token (taken from docker-compose)"
  type        = string
}



