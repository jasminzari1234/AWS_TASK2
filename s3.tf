






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

// Creating Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Some comment"
}
output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity
}

// Creating bucket policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.b.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.b.arn}"]
    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
