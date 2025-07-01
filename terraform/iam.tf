# IAM User for S3 Website Management
resource "aws_iam_user" "website_manager" {
  name = "${var.project_name}-${var.environment}-website-manager"

  tags = {
    Name = "${var.project_name}-${var.environment}-website-manager"
  }
}

# IAM Policy for S3 Website Management
resource "aws_iam_policy" "website_management" {
  name        = "${var.project_name}-${var.environment}-website-management"
  description = "Policy for managing S3 website bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.website.arn,
          "${aws_s3_bucket.website.arn}/*"
        ]
      }
    ]
  })
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "website_manager" {
  user       = aws_iam_user.website_manager.name
  policy_arn = aws_iam_policy.website_management.arn
}

# Output IAM user name
output "website_manager_user" {
  description = "IAM user for website management"
  value       = aws_iam_user.website_manager.name
}
