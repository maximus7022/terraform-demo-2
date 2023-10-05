resource "aws_s3_bucket" "remote_state" {
  bucket = var.bucket_name

  tags = {
    Name = "TF Remote state"
  }
}

resource "aws_dynamodb_table" "state_lock" {
  hash_key = "LockID"
  name     = var.dynamo_name

  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
