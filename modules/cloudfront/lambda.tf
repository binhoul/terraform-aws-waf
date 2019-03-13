resource "aws_lambda_function" "log_parser" {
  function_name = "${var.waf_prefix}_log_parser"
  description   = "This function parses CloudFront access logs to identify suspicious behavior, such as an abnormal amount of requests or errors. It then blocks those IP addresses for a customer-defined period of time."
  role          = "${aws_iam_role.lambda_role_log_parser.arn}"
  handler       = "log-parser.lambda_handler"
  filename      = "${path.module}/files/log-parser/log-parser.zip"
  runtime       = "python3.7"
  memory_size   = "512"
  timeout       = "300"

  environment {
    variables = {
      OUTPUT_BUCKET                                  = "${var.access_log_bucket}"
      IP_SET_ID_BLACKLIST                            = "${aws_waf_ipset.waf_blacklist_set.id}"
      IP_SET_ID_AUTO_BLOCK                           = "${aws_waf_ipset.waf_scanner_probe_set.id}"
      BLACKLIST_BLOCK_PERIOD                         = "${var.waf_block_period}"
      ERROR_PER_MINUTE_LIMIT                         = "${var.error_threshold}"
      SEND_ANONYMOUS_USAGE_DATA                      = "${var.send_anonymous_usage_data}"
      UUID                                           = "${random_uuid.uuid.result}"
      LIMIT_IP_ADDRESS_RANGES_PER_IP_MATCH_CONDITION = "${var.ip_address_ranges_limit}"
      MAX_AGE_TO_UPDATE                              = "30"
      REGION                                         = "${var.aws_region}"
      LOG_TYPE                                       = "${var.log_type}"
      METRIC_NAME_PREFIX                             = "test"
      LOG_LEVEL                                      = "${var.log_level}"
      STACK_NAME                                     = "${var.stack_name}"
    }
  }
}

resource "aws_lambda_function" "reputation_lists_parser" {
  function_name = "${var.waf_prefix}_reputation_lists_parser"
  description   = "This lambda function checks third-party IP reputation lists hourly for new IP ranges to block. These lists include the Spamhaus Dont Route Or Peer (DROP) and Extended Drop (EDROP) lists, the Proofpoint Emerging Threats IP list, and the Tor exit node list."
  role          = "${aws_iam_role.lambda_role_reputation_list_parser.arn}"
  handler       = "reputation-lists-parser.handler"
  filename      = "${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"
  runtime       = "nodejs8.10"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      SEND_ANONYMOUS_USAGE_DATA = "test"
      UUID                      = "${random_uuid.uuid.result}"
      METRIC_NAME_PREFIX        = "test"
      LOG_LEVEL                 = "${var.log_level}"
    }
  }
}

resource "aws_lambda_function" "bad_bot_parser" {
  count         = "${var.bad_bot_protection_activated ? 1 : 0}"
  function_name = "${var.waf_prefix}_bad_bot_parser"
  description   = "This lambda function will intercepts and inspects trap endpoint requests to extract its IP address, and then add it to an AWS WAF block list."
  role          = "${aws_iam_role.lambda_role_bad_bot.arn}"
  handler       = "access-handler.lambda_handler"
  filename      = "${path.module}/files/access-handler/access-handler.zip"
  runtime       = "python3.7"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      IP_SET_ID_BAD_BOT         = "${aws_waf_ipset.waf_bad_bot_set.id}"
      SEND_ANONYMOUS_USAGE_DATA = "${var.send_anonymous_usage_data}"
      UUID                      = "${random_uuid.uuid.result}"
      REGION                    = "${var.aws_region}"
      LOG_TYPE                  = "${var.endpoint}"
      METRIC_NAME_PREFIX        = "test"
      LOG_LEVEL                 = "INFO"
    }
  }
}

resource "aws_lambda_function" "custom_resource" {
  function_name = "${var.waf_prefix}_custom_resource"
  description   = "This lambda function configures the Web ACL rules based on the features enabled in the CloudFormation template. Parameters: yes"
  role          = "${aws_iam_role.lambda_role_custom_resource.arn}"
  handler       = "custom-resource.lambda_handler"
  filename      = "${path.module}/files/custom-resource/custom-resource.zip"
  runtime       = "python3.7"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      API_TYPE  = "${local.api_type}"
      LOG_LEVEL = "${var.log_level}"
    }
  }
}
