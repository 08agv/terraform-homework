provider aws {
    region = var.region 
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name 
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  key_name = aws_key_pair.deployer.key_name
  availability_zone = var.availability_zone
  instance_type = var.instance_type 
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  count = var.count_ec2

  tags = {
    name = "web-${count.index + 1}"
  }
}

# ami-078701cc0905d44e4


variable region {
  description = "Provide region"
  type = string 
  default = ""
}

variable key_name {
  description = "Provide key name"
  type = string 
  default = ""
}

variable ports {
  description = "List of ports"
  type = list 
  default = []
}

variable availability_zone {
    description = "Provide availability zone"
    type = string
    default = ""
}


variable instance_type {
  description = "Provide instance type"
  type = string
  default = ""
}

variable ami_id {
  description = "Provide ami id"
  type = string 
  default = ""
}

variable count_ec2 {
  description = "Provide count of ec2"
  type = number
  default = 1
}

