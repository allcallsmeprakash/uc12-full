resource "aws_iam_role" "lambda_exec_role" {
  name = "hello-world-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/hello.zip"
}

resource "aws_lambda_function" "hello_world" {
  function_name    = var.lambda_function_name
  filename         = data.archive_file.lambda_zip.output_path
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  depends_on       = [aws_iam_role.lambda_exec_role]
}


resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/hello-world-api"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/hello-world-lambda"
  retention_in_days = 7
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "Lambda-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/ApiGateway",
              "4XXError",
              "ApiName",
              "hello-world-api"
            ],
            [
              "AWS/ApiGateway",
              "5XXError",
              "ApiName",
              "hello-world-api"
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "API Gateway Errors"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [
              "AWS/Lambda",
              "Errors",
              "FunctionName",
              "hello-world-lambda"
            ],
            [
              "AWS/Lambda",
              "Throttles",
              "FunctionName",
              "hello-world-lambda"
            ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Lambda Errors/Throttles"
        }
      }
    ]
  })
}
