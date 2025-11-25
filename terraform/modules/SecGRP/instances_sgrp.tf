# Security Group for EC2
resource "aws_security_group" "tester_sg" {
  name        = "tester_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id

  tags = {
    Name = "${var.app_name}-sg"
  }
}
