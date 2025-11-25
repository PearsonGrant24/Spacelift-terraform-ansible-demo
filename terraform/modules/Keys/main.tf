resource "aws_key_pair" "demo_key" {
    key_name = "tester_key"
    public_key = file("~/.ssh/appKey.pub")  
}