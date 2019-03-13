locals {
  api_type    = "${var.endpoint == "cloudfront" ? "waf" : "waf-regional"}"
  waf_web_acl = "${var.waf_prefix}_web_acl"
}

data "aws_caller_identity" "current" {}

resource "random_uuid" "uuid" {}
