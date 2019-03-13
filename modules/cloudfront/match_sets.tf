###################################################################
# SQL Injection Condition
# Filters requests that contain possible malicious SQL code. The condition includes filters that evaluate the following parts of requests:
#     - Query string (URL & HTML decode transformation)
#     - URI (URL & HTML decode transformation)
#     - Body (URL & HTML decode transformation)
###################################################################
resource "aws_waf_sql_injection_match_set" "waf_sql_injection_set" {
  name = "${var.waf_prefix}-generic-detect-sqlinjection"

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuples {
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

resource "aws_waf_xss_match_set" "waf_xss_set" {
  name = "${var.waf_prefix}-generic-detect-xss"

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "BODY"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  xss_match_tuples {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

###################################################################
# IP Set based matching
###################################################################

resource "aws_waf_ipset" "waf_whitelist_set" {
  name = "${var.waf_prefix}-whiltelist-set"

  count = "${length(var.waf_whitelist_ipset)}"

  ip_set_descriptors {
    type  = "${var.ip_type}"
    value = "${var.waf_whitelist_ipset[count.index]}"
  }
}

resource "aws_waf_ipset" "waf_blacklist_set" {
  name = "${var.waf_prefix}-blacklist-set"

  count = "${length(var.waf_blacklist_ipset)}"

  ip_set_descriptors {
    type  = "${var.ip_type}"
    value = "${var.waf_blacklist_ipset[count.index]}"
  }
}

resource "aws_waf_ipset" "waf_scanner_probe_set" {
  name = "${var.waf_prefix}-scanner-probe-set"

  count = "${length(var.waf_scanner_probe_ipset)}"

  ip_set_descriptors {
    type  = "${var.ip_type}"
    value = "${var.waf_scanner_probe_ipset[count.index]}"
  }
}

resource "aws_waf_ipset" "waf_reputation_set" {
  name = "${var.waf_prefix}-reputation-set"

  count = "${length(var.waf_reputation_ipset)}"

  ip_set_descriptors {
    type  = "${var.ip_type}"
    value = "${var.waf_reputation_ipset[count.index]}"
  }
}

resource "aws_waf_ipset" "waf_bad_bot_set" {
  name = "${var.waf_prefix}-bad-bot-set"

  count = "${length(var.waf_bad_bot_ipset)}"

  ip_set_descriptors {
    type  = "${var.ip_type}"
    value = "${var.waf_bad_bot_ipset[count.index]}"
  }
}
