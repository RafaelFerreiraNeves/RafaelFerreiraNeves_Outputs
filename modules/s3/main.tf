resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-bucket-123456"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}
