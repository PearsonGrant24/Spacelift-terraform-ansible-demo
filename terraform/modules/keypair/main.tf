resource "aws_key_pair" "demo_key" {
  key_name   = "${var.app_name}-key"
  public_key = file("~/.ssh/appKey.pub")
}

