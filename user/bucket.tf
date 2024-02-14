provider "aws" {
  region = "ap-south-1"  

}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"  # Set your desired bucket name

  # Uncomment the below line if you want to enforce encryption on the bucket
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }

  # Uncomment the below block to enable versioning for the bucket
  # versioning {
  #   enabled = true
  # }

  # Uncomment the below block to enable logging for the bucket
  # logging {
  #   target_bucket = aws_s3_bucket.log_bucket.bucket
  #   target_prefix = "logs/"
  # }

  # Uncomment the below block to enable lifecycle rules for the bucket
  # lifecycle_rule {
  #   enabled = true
  #   prefix = ""
  #   expiration {
  #     days = 30
  #   }
  #   noncurrent_version_expiration {
  #     days = 90
  #   }
  # }

  # Uncomment the below block to enable bucket replication
  # replication_configuration {
  #   role = aws_iam_role.replication_role.arn
  #   destination {
  #     bucket = aws_s3_bucket.replicated_bucket.arn
  #   }
  # }
}
