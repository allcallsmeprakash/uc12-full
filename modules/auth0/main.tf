
terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.0"
    }
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_provider_client_id
  client_secret = var.auth0_provider_client_secret
}

resource "auth0_client" "hello_world_app" {
  name            = "HelloWorldApp"
  app_type        = "regular_web"
  oidc_conformant = true

  callbacks = [
    "https://${var.cloudfront_domain_name}/index.html"
  ]

  allowed_logout_urls = [
    "https://${var.cloudfront_domain_name}/logout"
  ]

  grant_types = [
    "authorization_code",
    "implicit",
    "refresh_token"
  ]
}
