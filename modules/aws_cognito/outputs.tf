output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.user_pool.id
}

output "user_pool_arn" {
  description = "Cognito User Pool ARN"
  value       = aws_cognito_user_pool.user_pool.arn
}
