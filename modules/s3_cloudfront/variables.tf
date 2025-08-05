variable "s3_bucket_name" {
  description = "Name of the S3 bucket for hosting the website"
  type        = string
}

variable "cloudfront_default_root_object" {
  description = "Default root object for CloudFront distribution"
  type        = string
}
