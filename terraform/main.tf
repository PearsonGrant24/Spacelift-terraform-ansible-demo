resource "aws_key_pair" "demo_key" {
    key_name = "tester_key"
    public_key = file("~/ssh/appKey.pub")  
}

resource "aws_vpc" "demo_vpc" {
    cidr_block           = "10.0.0.0/24"
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
      Name = "demo_vpc"
    }  
}

# creating subnet
resource "aws_subnet" "public_ip" {
    vpc_id          = aws_vpc.demo_vpc.id
    cidr_block      = "10.0.1.0/16"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "public_ip"
    }
}

# IGW
resource "aws_internet_gateway" "demo_igw" {
    vpc_id = aws_vpc.demo_vpc.id

    tags = {
    Name = "demo-igw"
  }
}

#routing table
resource "aws_route_table" "demo_route_tb" {
  vpc_id = aws_vpc.demo_vpc.id

  route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id       
    }
    tags = {
    Name = "public-demo-rt"
  }

}

#route assici
resource "aws_route_table_association" "demo-rta" {
    subnet_id = aws_subnet.public_ip.id 
    route_table_id = aws_route_table.demo_route_tb.id
}

# Security Group for EC2
resource "aws_security_group" "tester_sg" {
  name        = "tester_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id

  tags = {
    Name = "${var.app_name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "demo_sg_ipv4" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "demo_sg_ipv4_ssh" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "demo_eg_sg" {
    security_group_id = aws_security_group.tester_sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "server_1" {

    for_each = {
        for inst in local.instances : inst.name => inst.env
    }
 
    ami                     = data.aws_ami.ubuntu.id 
    instance_type           = "t2.micro"
    key_name                = aws_key_pair.demo_key.id
    subnet_id               = aws_subnet.public_ip.id
    vpc_security_group_ids  = [aws_security_group.tester_sg.id]

    tags = {
        Name          = each.key
        Environment  = each.value
    }
}