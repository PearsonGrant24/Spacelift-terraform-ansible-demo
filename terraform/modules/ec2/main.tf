
locals {
  environments = {
    dev   = 2
    stage = 2
    prod  = 2
  }

  instances = flatten([
    for env, count in local.environments : [
      for i in range(count) : {
        name = "${env}-${i + 1}"
        env  = env
      }
    ]
  ])
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "servers" {
  for_each = {
    for inst in local.instances : inst.name => inst
  }

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name        = each.value.name
    Environment = each.value.env
    App         = var.app_name
  }
}


