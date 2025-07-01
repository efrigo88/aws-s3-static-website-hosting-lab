output "cloudfront_domain" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.website.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.website.id
}

# Main HTTPS URL - Copy and paste this in your browser
output "website_url" {
  description = "🌐 Your website HTTPS URL (copy and paste this)"
  value       = "https://${aws_cloudfront_distribution.website.domain_name}"
}

# Alternative HTTP URL (S3 direct)
output "s3_website_url" {
  description = "Alternative HTTP URL (S3 direct)"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}
