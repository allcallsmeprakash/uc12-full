provider "aws" {
  region = "us-east-1"
}


terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.0"
    }
  }
}


module "s3_cloudfront" {
  source = "../../../modules/s3_cloudfront"
  s3_bucket_name = var.s3_bucket_name
  cloudfront_default_root_object = var.cloudfront_default_root_object
}

module "auth0" {
  source = "../../../modules/auth0"
  auth0_domain = var.auth0_domain
  auth0_provider_client_id = var.auth0_provider_client_id
  auth0_provider_client_secret  = var.auth0_provider_client_secret
  cloudfront_domain_name = module.s3_cloudfront.cloudfront_domain_name
}

module "aws_cognito" {
  source = "../../../modules/aws_cognito"
  auth0_client_id = module.auth0.auth0_client_id
  auth0_client_secret = module.auth0.auth0_client_secret
  auth0_domain = var.auth0_domain
  cloudfront_domain_name = module.s3_cloudfront.cloudfront_domain_name
}

module "lambda" {
  source = "../../../modules/lambda"
  lambda_function_name = var.lambda_function_name
  lambda_handler = var.lambda_handler
  lambda_runtime = var.lambda_runtime
}

module "api_gateway" {
  source = "../../../modules/api_gateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  cognito_user_pool_arn = module.aws_cognito.user_pool_arn
}
