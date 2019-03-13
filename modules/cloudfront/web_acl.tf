resource "aws_waf_web_acl" "WAFWebACL" {
    depends_on = [
      "aws_waf_rule.waf_whitelist",
      "aws_waf_rule.waf_blacklist",
      "aws_waf_rule.waf_scanner_probe",
      "aws_waf_rule.waf_reputation",
      "aws_waf_rule.waf_bad_bot",
      "aws_waf_rule.waf_sql_injection",
      "aws_waf_rule.waf_xss",
      ]
    name = "waf_web_acl"
    metric_name = "SecurityAutomationsMaliciousRequesters"
    default_action {
        type = "ALLOW"
    }
    rules {
        action {
            type = "ALLOW"
        }
        priority = 10
        rule_id = "${aws_waf_rule.waf_whitelist.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 20
        rule_id = "${aws_waf_rule.waf_blacklist.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 30
        rule_id = "${aws_waf_rule.waf_scanner_probe.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 40
        rule_id = "${aws_waf_rule.waf_reputation.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 50
        rule_id = "${aws_waf_rule.waf_bad_bot.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 60
        rule_id = "${aws_waf_rule.waf_sql_injection.id}"
    }
    rules {
        action {
            type = "BLOCK"
        }
        priority = 70
        rule_id = "${aws_waf_rule.waf_xss.id}"
    }
}
