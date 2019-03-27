resource "aws_lambda_permission" "log_parser" {
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.log_parser.function_name}"
  principal      = "s3.amazonaws.com"
  source_account = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_lambda_permission" "reputation_lists_parser" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.reputation_lists_parser.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.reputation_lists_parser.arn}"
}

resource "aws_lambda_permission" "bad_bot_parser" {
  action        = "lambda:*"
  function_name = "${aws_lambda_function.bad_bot_parser.function_name}"
  principal     = "apigateway.amazonaws.com"
}
