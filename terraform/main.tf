# Provider Configuration (Keep only one)
provider "aws" {
  region = "us-east-1"
}

# Fetch the Latest Amazon Linux AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Check if an EC2 Instance with the Tag "SpringAppServer" Exists
data "aws_instances" "existing_ec2" {
  filter {
    name   = "tag:Name"
    values = ["SpringAppServer"]
  }
}

# Create an EC2 Instance Only If None Exists
resource "aws_instance" "app_server" {
  count         = length(data.aws_instances.existing_ec2.ids) == 0 ? 1 : 0
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "SpringAppServer"
  }
}

# Security Group
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
