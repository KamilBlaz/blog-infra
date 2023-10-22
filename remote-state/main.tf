variable "bucket" {
  type = string
}

variable "dynamodb_table" {
  type = string
}

variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

module "remote_state" {
  source = "../modules/s3-remote-state"

  bucket         = var.bucket
  dynamodb_table = var.dynamodb_table

  project_name = var.project_name
  region       = var.region
}

output "bucket_name" {
  value = module.remote_state.bucket_name
}

output "lock_table_name" {
  value = module.remote_state.lock_table_name
}
