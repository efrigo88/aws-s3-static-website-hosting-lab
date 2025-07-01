# AWS S3 Static Website Hosting Lab

A complete infrastructure as code solution for hosting static websites on Amazon S3 using Terraform.

## 🚀 Features

- **S3 Static Website Hosting**: Configured with proper bucket policies and website endpoints
- **Infrastructure as Code**: Fully managed with Terraform
- **Modern Website Template**: Responsive, beautiful website included
- **IAM Management**: Dedicated IAM user for website management
- **Versioning**: S3 bucket versioning enabled for backup and rollback
- **Security**: Proper bucket policies and access controls

## 📁 Project Structure

```
aws-s3-static-website-hosting-lab/
├── terraform/
│   ├── provider.tf      # AWS provider configuration
│   ├── variables.tf     # Input variables
│   ├── s3.tf           # S3 bucket and website configuration
│   └── iam.tf          # IAM user and policies
├── website/
│   ├── index.html      # Main website page
│   ├── error.html      # 404 error page
│   └── styles.css      # CSS styles
├── scripts/
│   ├── deploy.sh       # Deployment script
│   └── destroy.sh      # Cleanup script
└── README.md
```

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.7)
- [AWS CLI](https://aws.amazon.com/cli/) configured
- AWS account with appropriate permissions

## ⚙️ Configuration

### 1. Environment Variables

Create a `.env` file in the root directory:

```bash
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=us-east-1
```

### 2. Variables (Optional)

You can customize the deployment by modifying `terraform/variables.tf`:

- `aws_region`: AWS region (default: us-east-1)
- `project_name`: Project name for resource naming
- `environment`: Environment name (default: playground)

## 🚀 Deployment

### Quick Start (Recommended)

1. **Set up AWS credentials**:
   ```bash
   aws configure
   ```

2. **Deploy the infrastructure**:
   ```bash
   ./scripts/deploy.sh
   ```

3. **Access your website**:
   The deployment will output the website URL. It will look like:
   ```
   http://aws-s3-static-website-hosting-lab-playground-website.s3-website-us-east-1.amazonaws.com
   ```

### Alternative: Manual Deployment

⚠️ **Note**: The provided scripts handle all Terraform operations automatically. Manual deployment is not recommended unless you need custom configurations.

If you must deploy manually:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## 🧹 Cleanup

To destroy all resources (Recommended):

```bash
./scripts/destroy.sh
```

### Alternative: Manual Cleanup

⚠️ **Note**: The destroy script handles cleanup automatically and removes local Terraform state files. Manual cleanup is not recommended.

If you must destroy manually:

```bash
cd terraform
terraform destroy
```

## 📊 Outputs

After deployment, Terraform will output:

- `website_endpoint`: S3 website endpoint URL
- `website_domain`: S3 website domain
- `bucket_name`: S3 bucket name
- `website_manager_user`: IAM user for website management

## 🎨 Customizing the Website

The website template is located in the `website/` directory:

- **`index.html`**: Main page with modern, responsive design
- **`error.html`**: 404 error page
- **`styles.css`**: CSS styles with beautiful gradients and animations

### Adding New Pages

1. Create new HTML files in the `website/` directory
2. Add corresponding `aws_s3_object` resources in `terraform/s3.tf`
3. Run `./scripts/deploy.sh` to upload the new files

### Example: Adding a new page

```hcl
# In terraform/s3.tf
resource "aws_s3_object" "about_html" {
  bucket       = aws_s3_bucket.website.id
  key          = "about.html"
  source       = "${path.module}/../website/about.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/../website/about.html")
}
```

## �� Security Features

- **Public Read Access**: Configured for static website hosting
- **IAM User**: Dedicated user with minimal required permissions
- **Bucket Policies**: Proper S3 bucket policies for public read access
- **Versioning**: Enabled for backup and rollback capabilities

## 🌐 Website Features

- **Responsive Design**: Works on desktop, tablet, and mobile
- **Modern UI**: Beautiful gradients, animations, and typography
- **Interactive Elements**: Buttons with hover effects
- **Error Handling**: Custom 404 page
- **Fast Loading**: Optimized CSS and minimal JavaScript

## 📝 Best Practices

1. **Use HTTPS**: Consider adding CloudFront for HTTPS support
2. **Custom Domain**: Configure Route 53 for custom domain names
3. **CDN**: Add CloudFront for global content delivery
4. **Monitoring**: Set up CloudWatch for website monitoring
5. **Backup**: Regular backups using S3 versioning

## 🐛 Troubleshooting

### Common Issues

1. **Bucket already exists**: Change the project name or environment in variables
2. **Permission denied**: Ensure AWS credentials have S3 and IAM permissions
3. **Website not accessible**: Check bucket policy and public access settings

### Debug Commands

```bash
# Check Terraform state (after deployment)
cd terraform && terraform show

# Validate configuration
cd terraform && terraform validate

# Check AWS S3 bucket
aws s3 ls s3://your-bucket-name

# Test website endpoint
curl http://your-website-endpoint
```

**Note**: For most operations, use the provided scripts instead of manual Terraform commands.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the deployment
5. Submit a pull request

## 📞 Support

For issues and questions:
- Create an issue in this repository
- Check the troubleshooting section above
- Review AWS S3 documentation

---

**Happy hosting! 🎉**