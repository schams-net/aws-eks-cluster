# CloudFront functions

resource "aws_cloudfront_function" "add_index_html" {
    name = "${lower(var.tags.Name)}-add-index-html"
    runtime = "cloudfront-js-1.0"
    comment = "Adds index.html if the URI does not have a file name or file extension"
    publish = true
    code = file("${path.module}/functions/add-index-html.js")
}
