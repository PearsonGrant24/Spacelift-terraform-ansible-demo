resource "aws_vpc_security_group_ingress_rule" "demo_sg_ipv4_ssh" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}
