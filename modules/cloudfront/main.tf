locals {
  api_type    = "${var.endpoint == "cloudfront" ? "waf" : "waf-regional"}"
  waf_web_acl = "${lower(var.stack_name)}_web_acl"
}

data "aws_caller_identity" "current" {}

resource "random_uuid" "uuid" {
  # keepers = {  #   change = "${timestamp()}"  # }
}
