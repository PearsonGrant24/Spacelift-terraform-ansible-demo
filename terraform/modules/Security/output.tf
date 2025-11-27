output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.demo_vpc.id
}

output "subnet_id" {
    description = "subnet id"
    value = aws_subnet.public_ip.id  
}

