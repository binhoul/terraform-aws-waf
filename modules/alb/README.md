## AWS Waf module for ALB
This module deploy AWS WAF on ALB

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_log_bucket | name for the Amazon S3 bucket where you want to store access logs files | string | - | yes |
| aws_region | - | string | - | yes |
| bad_bot_protection_activated | Activate Bad Bot Protection or not | string | `yes` | no |
| cross_site_scripting_protection_activated | Activate Cross-site Scripting Protection or not | string | `yes` | no |
| endpoint | Endpoint type, select one of alb and cloudfront | string | `alb` | no |
| error_threshold | If you chose yes for the Activate Scanners & Probes Protection parameter, enter the maximum   acceptable bad requests per minute per IP. If you chose to deactivate Scanners & Probes   protection, ignore this parameter. | string | `50` | no |
| http_flood_protection_activated | Activate HTTP Flood Protection or not | string | `yes` | no |
| ip_address_ranges_limit | - | string | `10000` | no |
| ip_type | Define which type of IP address is used | string | `IPV4` | no |
| log_level | Log level settings, set one of DEBUG, INFO, WARNING, ERROR, CRITICAL | string | `INFO` | no |
| reputation_lists_protection_activated | Activate Reputation List Protection or not | string | `yes` | no |
| request_threshold | If you chose yes for the Activate HTTP Flood Protection parameter, enter the maximum   acceptable requests per FIVE-minute period per IP address. Minimum value of 2000.   If you chose to deactivate this protection, ignore this parameter." | string | `2000` | no |
| scanner_probe_protection_activated | Activate Scanner & Probe Protection or not | string | `yes` | no |
| send_anonymous_usage_data | Send anonymous usage data to AWS or not, including blocked IP set, allowed requests num etc. | string | `false` | no |
| sql_injection_protection_activated | Activate SQL Injection Protection or not | string | `yes` | no |
| stack_name | AWS service name which waf applied to, it contains two types, ALB and CloudFront | string | `ALBStack` | no |
| tags | A map of tags to add to all resources | map | `<map>` | no |
| waf_bad_bot_ipset | Provide waf bad bot ip list to deny accessing web resources | list | `<list>` | no |
| waf_blacklist_ipset | Provide waf blacklist to deny accessing web resources | list | `<list>` | no |
| waf_block_period | If you chose yes for the Activate Scanners & Probes Protection parameters, enter the period   (in minutes) to block applicable IP addresses. If you chose to deactivate this protection,   ignore this parameter. | string | `240` | no |
| waf_http_flood_ipset | Provide waf http flood ip list to deny accessing web resources | list | `<list>` | no |
| waf_prefix | prefix | string | `waf` | no |
| waf_reputation_ipset | Provide waf bad reputation ip list to deny accessing web resources | list | `<list>` | no |
| waf_scanner_probe_ipset | Provide waf scanner and probe ip list to deny accessing web resources | list | `<list>` | no |
| waf_whitelist_ipset | Provide waf whitelist to allow accessing web resources | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| waf_web_acl_id | - |
