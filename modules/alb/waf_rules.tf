resource "aws_wafregional_rule" "waf_whitelist" {
  depends_on  = ["aws_wafregional_ipset.waf_whitelist_set"]
  name        = "${var.stack_name} WhiteList Rule"
  metric_name = "${var.stack_name}WhitelistRule"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_whitelist_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_blacklist" {
  depends_on  = ["aws_wafregional_ipset.waf_blacklist_set"]
  name        = "${var.stack_name} BlackList Rule"
  metric_name = "${var.stack_name}BlacklistRule"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_blacklist_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_scanner_probe" {
  depends_on  = ["aws_wafregional_ipset.waf_scanner_probe_set"]
  name        = "${var.stack_name} Scanner & Probe Rule"
  metric_name = "${var.stack_name}ScannerProbeRule"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_scanner_probe_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_reputation" {
  depends_on  = ["aws_wafregional_ipset.waf_reputation_set"]
  name        = "${var.stack_name} IP Reputation Rule"
  metric_name = "${var.stack_name}IPReputationRule"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_reputation_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_bad_bot" {
  depends_on  = ["aws_wafregional_ipset.waf_bad_bot_set"]
  name        = "${var.stack_name} Bad Bot Rule"
  metric_name = "${var.stack_name}BadBotRule"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_bad_bot_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_sql_injection" {
  depends_on  = ["aws_wafregional_sql_injection_match_set.waf_sql_injection_set"]
  name        = "${var.stack_name} SQL Injection Rule"
  metric_name = "${var.stack_name}SQLInjectionRule"

  predicate {
    data_id = "${aws_wafregional_sql_injection_match_set.waf_sql_injection_set.id}"
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_wafregional_rule" "waf_xss" {
  depends_on  = ["aws_wafregional_xss_match_set.waf_xss_set"]
  name        = "${var.stack_name} XSS Rule"
  metric_name = "${var.stack_name}XssRule"

  predicate {
    data_id = "${aws_wafregional_xss_match_set.waf_xss_set.id}"
    negated = false
    type    = "XssMatch"
  }
}

resource "aws_wafregional_rate_based_rule" "waf_rate_based_rule" {
  name        = "${var.stack_name} HTTP Flood Rule"
  metric_name = "${var.waf_prefix}HttpFloodRule"

  rate_key   = "IP"
  rate_limit = "${var.request_threshold}"
}
