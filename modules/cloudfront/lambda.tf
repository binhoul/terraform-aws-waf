resource "aws_lambda_function" "LambdaWAFBadBotParserFunction" {
  depends_on    = ["aws_s3_bucket_object.access_handler_zip"]
  function_name = "${var.waf_prefix}-LambdaWAFBadBotParserFunction-${element(split("-",uuid()),0)}"
  description   = "This lambda function will intercepts and inspects trap endpoint requests to extract its IP address, and then add it to an AWS WAF block list."
  role          = "${aws_iam_role.lambda_role_bad_bot.arn}"
  handler       = "access-handler.lambda_handler"
  filename      = "${path.module}/files/access-handler/access-handler.zip"
  runtime       = "python2.7"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      CloudFrontAccessLogBucket              = "${var.access_log_bucket}"
      ActivateBadBotProtectionParam          = "${var.bad_bot_protection_activated}"
      ActivateHttpFloodProtectionParam       = "${var.http_flood_protection_activated}"
      ActivateReputationListsProtectionParam = "${var.reputation_lists_protection_activated}"
      ActivateScansProbesProtectionParam     = "${var.scanner_probe_protection_activated}"
      CrossSiteScriptingProtectionParam      = "${var.cross_site_scripting_protection_activated}"
      SqlInjectionProtectionParam            = "${var.sql_injection_protection_activated}"
      ErrorThreshold                         = "${var.error_threshold}"
      RequestThreshold                       = "${var.request_threshold}"
      WAFBlockPeriod                         = "${var.waf_block_period}"
      WAFBadBotSet                           = "${aws_waf_ipset.waf_bad_bot_set.id}"
      SendAnonymousUsageData                 = "${var.send_anonymous_usage_data}"
      UUID                                   = "${uuid()}"
    }
  }
}

resource "aws_lambda_function" "LambdaWAFCustomResourceFunction" {
  depends_on    = ["aws_s3_bucket_object.custom_resource_zip"]
  function_name = "${var.waf_prefix}-LambdaWAFCustomResourceFunction-${element(split("-",uuid()),0)}"
  description   = "This lambda function configures the Web ACL rules based on the features enabled in the CloudFormation template. Parameters: yes"
  role          = "${aws_iam_role.lambda_role_custom_resource.arn}"
  handler       = "custom-resource.lambda_handler"
  filename      = "${path.module}/files/custom-resource/custom-resource.zip"
  runtime       = "python2.7"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      CloudFrontAccessLogBucket              = "${var.access_log_bucket}"
      ActivateBadBotProtectionParam          = "${var.bad_bot_protection_activated}"
      ActivateHttpFloodProtectionParam       = "${var.http_flood_protection_activated}"
      ActivateReputationListsProtectionParam = "${var.reputation_lists_protection_activated}"
      ActivateScansProbesProtectionParam     = "${var.scanner_probe_protection_activated}"
      CrossSiteScriptingProtectionParam      = "${var.cross_site_scripting_protection_activated}"
      SqlInjectionProtectionParam            = "${var.sql_injection_protection_activated}"
      ErrorThreshold                         = "${var.error_threshold}"
      RequestThreshold                       = "${var.request_threshold}"
      WAFBlockPeriod                         = "${var.waf_block_period}"
      SendAnonymousUsageData                 = "${var.send_anonymous_usage_data}"
    }
  }
}

resource "aws_lambda_function" "LambdaWAFLogParserFunction" {
  depends_on    = ["aws_s3_bucket_object.log_parser_zip"]
  function_name = "${var.waf_prefix}-LambdaWAFLogParserFunction-${element(split("-",uuid()),0)}"
  description   = "This function parses CloudFront access logs to identify suspicious behavior, such as an abnormal amount of requests or errors. It then blocks those IP addresses for a customer-defined period of time."
  role          = "${aws_iam_role.lambda_role_log_parser.arn}"
  handler       = "log-parser.lambda_handler"
  filename      = "${path.module}/files/log-parser/log-parser.zip"
  runtime     = "python2.7"
  memory_size = "512"
  timeout     = "300"

  environment {
    variables = {
      CloudFrontAccessLogBucket              = "${var.access_log_bucket}"
      ActivateBadBotProtectionParam          = "${var.bad_bot_protection_activated}"
      ActivateHttpFloodProtectionParam       = "${var.http_flood_protection_activated}"
      ActivateReputationListsProtectionParam = "${var.reputation_lists_protection_activated}"
      ActivateScansProbesProtectionParam     = "${var.scanner_probe_protection_activated}"
      CrossSiteScriptingProtectionParam      = "${var.cross_site_scripting_protection_activated}"
      SqlInjectionProtectionParam            = "${var.sql_injection_protection_activated}"
      ErrorThreshold                         = "${var.error_threshold}"
      RequestThreshold                       = "${var.request_threshold}"
      WAFBlockPeriod                         = "${var.waf_block_period}"
      BlacklistIPSetID                       = "${aws_waf_ipset.waf_blacklist_set.id}"
      AutoBlockIPSetID                       = "${aws_waf_ipset.waf_scanner_probe_set.id}"
      SendAnonymousUsageData                 = "${var.send_anonymous_usage_data}"
      UUID                                   = "${uuid()}"
    }
  }
}

resource "aws_lambda_function" "LambdaWAFReputationListsParserFunction" {
  depends_on    = ["aws_s3_bucket_object.reputation_lists_parser_zip"]
  function_name = "${var.waf_prefix}-LambdaWAFReputationListsParserFunction-${element(split("-",uuid()),0)}"
  description   = "This lambda function checks third-party IP reputation lists hourly for new IP ranges to block. These lists include the Spamhaus Dont Route Or Peer (DROP) and Extended Drop (EDROP) lists, the Proofpoint Emerging Threats IP list, and the Tor exit node list."
  role          = "${aws_iam_role.lambda_role_reputation_list_parser.arn}"
  handler       = "reputation-lists-parser.handler"
  filename      = "${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"
  runtime       = "nodejs8.10"
  memory_size   = "128"
  timeout       = "300"

  environment {
    variables = {
      CloudFrontAccessLogBucket              = "${var.access_log_bucket}"
      ActivateBadBotProtectionParam          = "${var.bad_bot_protection_activated}"
      ActivateHttpFloodProtectionParam       = "${var.http_flood_protection_activated}"
      ActivateReputationListsProtectionParam = "${var.reputation_lists_protection_activated}"
      ActivateScansProbesProtectionParam     = "${var.scanner_probe_protection_activated}"
      CrossSiteScriptingProtectionParam      = "${var.cross_site_scripting_protection_activated}"
      SqlInjectionProtectionParam            = "${var.sql_injection_protection_activated}"
      ErrorThreshold                         = "${var.error_threshold}"
      RequestThreshold                       = "${var.request_threshold}"
      WAFBlockPeriod                         = "${var.waf_block_period}"
      SendAnonymousUsageData                 = "${var.send_anonymous_usage_data}"
    }
  }
}
