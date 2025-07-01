# S3 Bucket for Static Website Hosting
resource "aws_s3_bucket" "website" {
  bucket = "${var.project_name}-${var.environment}-website"

  tags = {
    Name = "${var.project_name}-${var.environment}-website"
  }
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Public Access Block (disable for website hosting)
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 Bucket ACL
resource "aws_s3_bucket_acl" "website" {
  depends_on = [
    aws_s3_bucket_public_access_block.website,
    aws_s3_bucket_ownership_controls.website,
  ]

  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
}

# S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# S3 Bucket Policy for Public Read Access
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.website]
}

# Upload website files
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "${path.module}/../website/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/../website/index.html")
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  source       = "${path.module}/../website/error.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/../website/error.html")
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.website.id
  key          = "styles.css"
  source       = "${path.module}/../website/styles.css"
  content_type = "text/css"
  etag         = filemd5("${path.module}/../website/styles.css")
}

# Outputs
output "website_endpoint" {
  description = "S3 website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_domain" {
  description = "S3 website domain"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}

output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.website.id
}
