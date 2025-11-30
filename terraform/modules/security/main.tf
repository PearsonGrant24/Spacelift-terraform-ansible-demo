

resource "aws_security_group" "main" {
  name        = "${var.app_name}-sg"
  description = "Main security group for EC2"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.app_name}-sg"
  }
}

# SSH Ingress
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# HTTP Ingress
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Egress allow all
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

output "security_group_id" {
  value = aws_security_group.main.id
}
