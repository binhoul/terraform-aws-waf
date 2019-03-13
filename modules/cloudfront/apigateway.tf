resource "aws_api_gateway_rest_api" "bad_bot" {
  name        = "${var.waf_prefix} - WAF Bad Bot API"
  description = "API created by AWS WAF Security Automations. This endpoint will be used to capture bad bots."
}

resource "aws_api_gateway_resource" "bad_bot" {
  rest_api_id = "${aws_api_gateway_rest_api.bad_bot.id}"
  parent_id   = "${aws_api_gateway_rest_api.bad_bot.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "bad_bot" {
  rest_api_id   = "${aws_api_gateway_rest_api.bad_bot.id}"
  resource_id   = "${aws_api_gateway_resource.bad_bot.id}"
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    method.request.header.X-Forwarded-For = false
  }
}

resource "aws_api_gateway_integration" "bad_bot" {
  rest_api_id             = "${aws_api_gateway_rest_api.bad_bot.id}"
  resource_id             = "${aws_api_gateway_resource.bad_bot.id}"
  http_method             = "${aws_api_gateway_method.bad_bot.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.bad_bot_parser.arn}/invocations"
}

resource "aws_api_gateway_deployment" "bad_bot" {
  depends_on = ["aws_api_gateway_integration.bad_bot"]

  rest_api_id = "${aws_api_gateway_rest_api.bad_bot.id}"
  description = "CloudFormation Deployment Stage"
  stage_name  = "CFDeploymentStage"
}

resource "aws_api_gateway_stage" "bad_bot" {
  stage_name    = "ProdStage"
  rest_api_id   = "${aws_api_gateway_rest_api.bad_bot.id}"
  deployment_id = "${aws_api_gateway_deployment.bad_bot.id}"
  description   = "Production Stage"
}
