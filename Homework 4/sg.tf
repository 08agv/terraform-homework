resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

    ingress {
    description      = "TLS from VPC"
    from_port        = var.ports [0]
    to_port          = var.ports [0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "TLS from VPC"
    from_port        = var.ports [1]
    to_port          = var.ports [1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = var.ports [2]
    to_port          = var.ports [2]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}