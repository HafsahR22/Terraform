provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {               
  default = true
}

resource "aws_instance" "jenkins_instance" {
  ami           = "ami-051f7e7f6c2f40dc1"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  security_groups   = [aws_security_group.Jenkins.name]
tags = {
    Name = "Jenkins-Instance"
  }
  