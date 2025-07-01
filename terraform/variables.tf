# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "aws-s3-static-website-hosting-lab"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "playground"
}
