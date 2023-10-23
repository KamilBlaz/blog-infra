output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "lock_table_name" {
  value = aws_dynamodb_table.this.name
}
