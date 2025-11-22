
# creating subnet
resource "aws_subnet_id" "public_id" {
  
}

# IGW
resource "aws_internet_gateway" "igw" {
  
}
#routin table
resource "aws_route_table" "demo_route_tb" {
  
}




resource "aws_instance" "server_1" {
  ami           = "asdsfvb"
  instance_type = "t2.small"
  subnet_id = aws_subnet_id.public_id.id

  tags = {
    Name = "App-Server1"
  }
}