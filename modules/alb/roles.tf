data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "STSAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    effect = "Allow"
  }
}

###############################################################################
# Custom resource
###############################################################################
resource "aws_iam_role" "lambda_role_custom_resource" {
  name               = "${var.waf_prefix}${var.stack_name}LambdaRoleCustomResource"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy" "custom_resource" {
  name   = "${var.waf_prefix}${var.stack_name}CustomResource"
  role   = "${aws_iam_role.lambda_role_custom_resource.id}"
  policy = "${data.aws_iam_policy_document.custom_resource.json}"
}

data "aws_iam_policy_document" "custom_resource" {
  statement {
    actions = [
      "waf-regional:GetChangeToken",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "s3:CreateBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutBucketNotification",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::${var.access_log_bucket}",
    ]
  }

  statement {
    actions = [
      "lambda:*",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:*",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetWebACL",
      "waf-regional:UpdateWebACL",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:webacl/${aws_wafregional_web_acl.WAFWebACL.id}",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetRule",
      "waf-regional:UpdateWebACL",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:rule/*",
    ]
  }

  statement {
    actions = [
      "waf-regional:CreateRateBasedRule",
      "waf-regional:GetRateBasedRule",
      "waf-regional:ListRateBasedRules",
      "waf-regional:UpdateRateBasedRule",
      "waf-regional:DeleteRateBasedRule",
      "waf-regional:UpdateWebACL",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ratebasedrule/*",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetIPSet",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

###############################################################################
# Bad Bot
###############################################################################
resource "aws_iam_role" "lambda_role_bad_bot" {
  count              = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name               = "${var.waf_prefix}${var.stack_name}LambdaRoleBadBot"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy" "bad_bot" {
  count  = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name   = "${var.waf_prefix}${var.stack_name}BadBot"
  role   = "${aws_iam_role.lambda_role_bad_bot.id}"
  policy = "${data.aws_iam_policy_document.bad_bot.json}"
}

data "aws_iam_policy_document" "bad_bot" {
  count = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"

  statement {
    actions = [
      "waf-regional:GetChangeToken",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetIPSet",
      "waf-regional:UpdateIPSet",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_bad_bot_set.id}",
    ]
  }

  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

###############################################################################
# Log Parser
###############################################################################
resource "aws_iam_role" "lambda_role_log_parser" {
  count              = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name               = "${var.waf_prefix}${var.stack_name}LambdaRoleLogParser"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy" "log_parser" {
  count  = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name   = "${var.waf_prefix}${var.stack_name}LogParser"
  role   = "${aws_iam_role.lambda_role_log_parser.id}"
  policy = "${data.aws_iam_policy_document.log_parser.json}"
}

data "aws_iam_policy_document" "log_parser" {
  count = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"

  statement {
    actions = [
      "waf-regional:GetChangeToken",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetIPSet",
      "waf-regional:UpdateIPSet",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_blacklist_set.id}",
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_scanner_probe_set.id}",
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::${var.access_log_bucket}/*",
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:s3:::${var.access_log_bucket}/aws-waf-security-automations-current-blocked-ips.json",
    ]
  }

  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

###############################################################################
# Reputation List Parser
###############################################################################
resource "aws_iam_role" "lambda_role_reputation_list_parser" {
  count              = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name               = "${var.waf_prefix}${var.stack_name}LambdaRoleReputationListParser"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role_policy" "reputation_list_parser" {
  count  = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"
  name   = "${var.waf_prefix}${var.stack_name}ReputationListParser"
  role   = "${aws_iam_role.lambda_role_reputation_list_parser.id}"
  policy = "${data.aws_iam_policy_document.reputation_list_parser.json}"
}

data "aws_iam_policy_document" "reputation_list_parser" {
  count = "${var.scanner_probe_protection_activated == "yes" ? 1 : 0}"

  statement {
    actions = [
      "waf-regional:GetChangeToken",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "waf-regional:GetIPSet",
      "waf-regional:UpdateIPSet",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:waf-regional:${var.aws_region}:${data.aws_caller_identity.current.account_id}:ipset/${aws_wafregional_ipset.waf_reputation_set.id}",
    ]
  }

  statement {
    actions = [
      "cloudwatch:GetMetricStatistics",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}
