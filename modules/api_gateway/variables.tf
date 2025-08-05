variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  type        = string
}
