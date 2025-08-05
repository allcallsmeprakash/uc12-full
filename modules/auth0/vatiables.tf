variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
}

variable "auth0_provider_client_id" {
  description = "Auth0 client ID"
  type        = string
}

variable "auth0_provider_client_secret" {
  description = "Auth0 client secret"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFront domain name for callback/logout URLs"
  type        = string
}
