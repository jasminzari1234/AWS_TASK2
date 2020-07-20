






// Creating S3 bucket
resource "aws_s3_bucket" "b" {
  bucket = "jazbucket"
  acl    = "private"
  tags = {
    Name = "lwbucket"
  }
}
locals {
  s3_origin_id = "myS3Origin"
}
output "b" {
  value = aws_s3_bucket.b
}

