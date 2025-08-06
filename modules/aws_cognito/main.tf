resource "aws_cognito_user_pool" "user_pool" {
  name = "hello-world-user-pool"
}

resource "aws_cognito_identity_provider" "auth0" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  provider_name = "Auth0"
  provider_type = "OIDC"

  provider_details = {
    client_id                 = var.auth0_client_id
    client_secret             = var.auth0_client_secret
    authorize_scopes          = "openid email profile"
    oidc_issuer               = "https://${var.auth0_domain}"
    attributes_request_method = "GET"
  }

  attribute_mapping = {
    email = "email"
    name  = "name"
  }

  depends_on = [aws_cognito_user_pool.user_pool]
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                             = "hello-world-client"
  user_pool_id                     = aws_cognito_user_pool.user_pool.id
  generate_secret                  = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows              = ["code", "implicit"]
  allowed_oauth_scopes            = ["email", "openid", "profile"]

  callback_urls = [
    "https://${var.cloudfront_domain_name}/index.html"
  ]

  logout_urls = [
    "https://${var.cloudfront_domain_name}/logout"
  ]

  supported_identity_providers = ["COGNITO", "Auth0"]

  depends_on = [
    aws_cognito_identity_provider.auth0
  ]
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "hello-world-app-prod-domain"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

# Create a test user (optional - for development)
resource "aws_cognito_user" "test_user" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  username     = "Admin"

  attributes = {
    email          = "dilliprakashr.kalava@hcltech.com"
    email_verified = "true"
  }

  temporary_password = "Admin@1234"
  message_action     = "SUPPRESS"

  lifecycle {
    ignore_changes = [password]
  }
}
