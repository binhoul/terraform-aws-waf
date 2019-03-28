resource "aws_waf_web_acl" "WAFWebACL" {
  name        = "${local.waf_web_acl}"
  metric_name = "SecurityAutomationsMaliciousRequesters"

  default_action {
    type = "ALLOW"
  }
}
