output "api_url" {
  description = "Base URL of the deployed API Gateway"
  value       = "${aws_api_gateway_rest_api.hello_api.execution_arn}/prod/hello"
}
