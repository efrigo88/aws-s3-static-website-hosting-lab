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
