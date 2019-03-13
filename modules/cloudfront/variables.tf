variable "aws_region" {}

variable "sql_injection_protection_activated" {
  description = "Activate SQL Injection Protection or not"
  default     = true
}

variable "cross_site_scripting_protection_activated" {
  description = "Activate Cross-site Scripting Protection or not"
  default     = true
}

variable "http_flood_protection_activated" {
  description = "Activate HTTP Flood Protection or not"
  default     = true
}

variable "scanner_probe_protection_activated" {
  description = "Activate Scanner & Probe Protection or not"
  default     = true
}

variable "reputation_lists_protection_activated" {
  description = "Activate Reputation List Protection or not"
  default     = true
}

variable "bad_bot_protection_activated" {
  description = "Activate Bad Bot Protection or not"
  default     = true
}

variable "endpoint" {
  description = "Endpoint type"
  default     = "CLOUDFRONT"
}

variable "access_log_bucket" {
  description = "name for the Amazon S3 bucket where you want to store access logs files"
}

variable "request_threshold" {
  description = <<EOF
  If you chose yes for the Activate HTTP Flood Protection parameter, enter the maximum
  acceptable requests per FIVE-minute period per IP address. Minimum value of 2000.
  If you chose to deactivate this protection, ignore this parameter."
EOF

  default = 2000
}

variable "error_threshold" {
  description = <<EOF
  If you chose yes for the Activate Scanners & Probes Protection parameter, enter the maximum
  acceptable bad requests per minute per IP. If you chose to deactivate Scanners & Probes
  protection, ignore this parameter.
EOF

  default = 50
}

variable "waf_block_period" {
  description = <<EOF
  If you chose yes for the Activate Scanners & Probes Protection parameters, enter the period
  (in minutes) to block applicable IP addresses. If you chose to deactivate this protection,
  ignore this parameter.
EOF

  default = 240
}

variable "waf_prefix" {
  description = "prefix"
  default     = "waf"
}

variable "stack_name" {
  description = ""
  default     = "CloudFrontStack"
}

variable "ip_type" {
  description = "Define which type of IP address is used"
  default     = "IPV4"
}

variable "waf_whitelist_ipset" {
  description = "Provide waf whitelist to allow accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "waf_blacklist_ipset" {
  description = "Provide waf blacklist to deny accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "waf_scanner_probe_ipset" {
  description = "Provide waf scanner and probe ip list to deny accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "waf_reputation_ipset" {
  description = "Provide waf bad reputation ip list to deny accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "waf_bad_bot_ipset" {
  description = "Provide waf bad bot ip list to deny accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "waf_http_flood_ipset" {
  description = "Provide waf http flood ip list to deny accessing web resources"
  default     = ["0.0.0.0/32"]
}

variable "send_anonymous_usage_data" {
  description = ""
  default     = true
}

variable "waf_perfix" {
  description = ""
  default     = "waf"
}

variable "lambda_files_bucket" {
  description = ""
  default     = ""
}
