# resource "aws_s3_bucket" "waf_store_files" {
#   bucket = "${var.lambda_files_bucket}"
#   acl    = "private"

#   tags {
#     Name        = "WAF Lambda Files"
#     Environment = "Production"
#   }
# }

# resource "aws_s3_bucket_object" "log_parser_zip" {
#   depends_on = ["aws_s3_bucket.waf_store_files"]
#   bucket     = "${aws_s3_bucket.waf_store_files.id}"
#   key        = "log-parser.zip"
#   source     = "${path.module}/files/log-parser/log-parser.zip"
#   etag       = "${md5(file("${path.module}/files/log-parser/log-parser.zip"))}"
# }

# resource "aws_s3_bucket_object" "custom_resource_zip" {
#   depends_on = ["aws_s3_bucket.waf_store_files"]
#   bucket     = "${aws_s3_bucket.waf_store_files.id}"
#   key        = "custom-resource.zip"
#   source     = "${path.module}/files/custom-resource/custom-resource.zip"
#   etag       = "${md5(file("${path.module}/files/custom-resource/custom-resource.zip"))}"
# }

# resource "aws_s3_bucket_object" "access_handler_zip" {
#   depends_on = ["aws_s3_bucket.waf_store_files"]
#   bucket     = "${aws_s3_bucket.waf_store_files.id}"
#   key        = "access-handler.zip"
#   source     = "${path.module}/files/access-handler/access-handler.zip"
#   etag       = "${md5(file("${path.module}/files/access-handler/access-handler.zip"))}"
# }

# resource "aws_s3_bucket_object" "reputation_lists_parser_zip" {
#   depends_on = ["aws_s3_bucket.waf_store_files"]
#   bucket     = "${aws_s3_bucket.waf_store_files.id}"
#   key        = "reputation-lists-parser.zip"
#   source     = "${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"
#   etag       = "${md5(file("${path.module}/files/reputation-lists-parser/reputation-lists-parser.zip"))}"
# }

# resource "aws_s3_bucket_object" "solution_helper_zip" {
#   depends_on = ["aws_s3_bucket.waf_store_files"]
#   bucket     = "${aws_s3_bucket.waf_store_files.id}"
#   key        = "solution-helper.zip"
#   source     = "${path.module}/files/solution-helper/solution-helper.zip"
#   etag       = "${md5(file("${path.module}/files/solution-helper/solution-helper.zip"))}"
# }
