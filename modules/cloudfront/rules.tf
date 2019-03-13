resource "aws_waf_rule" "waf_whitelist" {
  depends_on  = ["aws_waf_ipset.waf_whitelist_set"]
  name        = "${var.waf_prefix} ${var.stack_name} WhiteList Rule"
  metric_name = "${var.stack_name}WhitelistRule"

  predicates {
    data_id = "${aws_waf_ipset.waf_whitelist_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "waf_blacklist" {
  depends_on  = ["aws_waf_ipset.waf_blacklist_set"]
  name        = "${var.waf_prefix} ${var.stack_name} BlackList Rule"
  metric_name = "${var.stack_name}BlacklistRule"

  predicates {
    data_id = "${aws_waf_ipset.waf_blacklist_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "waf_scanner_probe" {
  depends_on  = ["aws_waf_ipset.waf_scanner_probe_set"]
  name        = "${var.waf_prefix} ${var.stack_name} Scanner & Probe Rule"
  metric_name = "${var.stack_name}ScannerProbeRule"

  predicates {
    data_id = "${aws_waf_ipset.waf_scanner_probe_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "waf_reputation" {
  depends_on  = ["aws_waf_ipset.waf_reputation_set"]
  name        = "${var.waf_prefix} ${var.stack_name} IP Reputation Rule"
  metric_name = "${var.stack_name}IPReputationRule"

  predicates {
    data_id = "${aws_waf_ipset.waf_reputation_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "waf_bad_bot" {
  depends_on  = ["aws_waf_ipset.waf_bad_bot_set"]
  name        = "${var.waf_prefix} ${var.stack_name} Bad Bot Rule"
  metric_name = "${var.stack_name}BadBotRule"

  predicates {
    data_id = "${aws_waf_ipset.waf_bad_bot_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "waf_sql_injection" {
  depends_on  = ["aws_waf_sql_injection_match_set.waf_sql_injection_set"]
  name        = "${var.waf_prefix} ${var.stack_name} SQL Injection Rule"
  metric_name = "${var.stack_name}SQLInjectionRule"

  predicates {
    data_id = "${aws_waf_sql_injection_match_set.waf_sql_injection_set.id}"
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_waf_rule" "waf_xss" {
  depends_on  = ["aws_waf_xss_match_set.waf_xss_set"]
  name        = "${var.waf_prefix} ${var.stack_name} XSS Rule"
  metric_name = "${var.stack_name}XssRule"

  predicates {
    data_id = "${aws_waf_xss_match_set.waf_xss_set.id}"
    negated = false
    type    = "XssMatch"
  }
}
