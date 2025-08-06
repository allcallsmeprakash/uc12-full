variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
}

variable "auth0_provider_client_id" {
  description = "Auth0 client ID"
  type        = string
}


variable "auth0_provider_client_secret" {
  type      = string
  sensitive = true
}

variable "cloudfront_domain_name" {
  description = "CloudFront domain name for callback/logout URLs"
  type        = string
}
