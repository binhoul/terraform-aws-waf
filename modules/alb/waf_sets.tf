###################################################################
# SQL Injection Condition
# Filters requests that contain possible malicious SQL code. The condition includes filters that evaluate the following parts of requests:
#     - Query string (URL & HTML decode transformation)
#     - URI (URL & HTML decode transformation)
#     - Body (URL & HTML decode transformation)
###################################################################
resource "aws_wafregional_sql_injection_match_set" "waf_sql_injection_set" {
  name = "detect-sqlinjection-set"

  sql_injection_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

###################################################################
# Cross-site Scripting Condition
# Filters requests that contain possible malicious scripts. The condition includes filters that evaluate the following parts of requests:
#     - Query string (URL & HTML decode transformation)
#     - URI (URL & HTML decode transformation)
#     - Body (URL & HTML decode transformation)
###################################################################

resource "aws_wafregional_xss_match_set" "waf_xss_set" {
  name = "detect-xss-set"

  xss_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuple {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

###################################################################
# IP Set based matching
###################################################################

resource "aws_wafregional_ipset" "waf_whitelist_set" {
  name = "whiltelist-set"

  count = "${length(var.waf_whitelist_ipset)}"

  ip_set_descriptor {
    type  = "${var.ip_type}"
    value = "${var.waf_whitelist_ipset[count.index]}"
  }
}

resource "aws_wafregional_ipset" "waf_blacklist_set" {
  name = "blacklist-set"

  count = "${length(var.waf_blacklist_ipset)}"

  ip_set_descriptor {
    type  = "${var.ip_type}"
    value = "${var.waf_blacklist_ipset[count.index]}"
  }
}

resource "aws_wafregional_ipset" "waf_scanner_probe_set" {
  name = "scanner-probe-set"

  count = "${length(var.waf_scanner_probe_ipset)}"

  ip_set_descriptor {
    type  = "${var.ip_type}"
    value = "${var.waf_scanner_probe_ipset[count.index]}"
  }
}

resource "aws_wafregional_ipset" "waf_reputation_set" {
  name = "reputation-set"

  count = "${length(var.waf_reputation_ipset)}"

  ip_set_descriptor {
    type  = "${var.ip_type}"
    value = "${var.waf_reputation_ipset[count.index]}"
  }
}

resource "aws_wafregional_ipset" "waf_bad_bot_set" {
  name = "bad-bot-set"

  count = "${length(var.waf_bad_bot_ipset)}"

  ip_set_descriptor {
    type  = "${var.ip_type}"
    value = "${var.waf_bad_bot_ipset[count.index]}"
  }
}
