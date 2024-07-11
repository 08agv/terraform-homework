provider "aws" {
  region = "us-west-2"
}

# Add Bastion key

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Provision 3 EC2

resource "aws_instance" "web" {
  ami           = "ami-078701cc0905d44e4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  count = 3
  key_name = aws_key_pair.deployer.key_name
  user_data = file("apache.sh")
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  
  tags = {
    Name = "web-${count.index + 1}"
  }
}

output ec2 {
    value = aws_instance.web[0].public_ip
}
