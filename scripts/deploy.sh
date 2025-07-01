#!/bin/bash

# Exit on error
set -e

# Source environment variables
source .env

# Export AWS credentials from .env
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION

# Initialize and apply Terraform
cd terraform
terraform init
terraform validate
terraform apply -auto-approve

echo "✅ Deployment completed successfully!"