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