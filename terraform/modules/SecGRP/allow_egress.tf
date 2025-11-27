resource "aws_vpc_security_group_egress_rule" "demo_eg_sg" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

