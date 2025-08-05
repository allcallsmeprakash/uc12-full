# S3 and CloudFront
s3_bucket_name                = "hello-world-webapp-prod"
cloudfront_default_root_object = "index.html"

# Auth0
auth0_domain                  = "dev-gfew5m8jtuzrrhhw.us.auth0.com"
auth0_provider_client_id     = "rZyBhpq7SsMgyhxXTPbjfmRunEZHDFNq"
auth0_provider_client_secret = "iFLPIid-tlvMK9igrZfZGnWiV6cHJI1TNZRrLN_o-vHDmJ7lKbtXuxoNTxABAsq5"

# Lambda
lambda_function_name         = "hello-world-lambda"
lambda_handler               = "index.handler"
lambda_runtime               = "nodejs18.x"
lambda_zip_path              = "lambdazip/hello_world.zip"
