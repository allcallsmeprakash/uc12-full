output "cloudfront_domain_name" {
  value = module.s3_cloudfront.cloudfront_domain_name
}

output "api_gateway_url" {
  value = module.api_gateway.api_url
}
