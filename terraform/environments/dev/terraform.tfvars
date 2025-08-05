# S3 and CloudFront
s3_bucket_name                = "hello-world-webapp-prod"
cloudfront_default_root_object = "index.html"

# Auth0
auth0_domain                  = "your-auth0-domain.auth0.com"
auth0_provider_client_id     = "your-auth0-client-id"
auth0_provider_client_secret = "your-auth0-client-secret"

# Lambda
lambda_function_name         = "hello-world-lambda"
lambda_handler               = "index.handler"
lambda_runtime               = "nodejs18.x"
lambda_zip_path              = "lambda/hello_world/hello_world.zip"
