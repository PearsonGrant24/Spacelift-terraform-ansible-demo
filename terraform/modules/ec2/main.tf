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