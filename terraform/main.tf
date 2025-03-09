provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08b5b3a93ed654d19" # Replace with latest Amazon Linux AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.app_sg.name]

  tags = {
    Name = "SpringAppServer"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Allow inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
