provider "aws" {
  region = "us-east-1"
}
# this declares the provider 

data "aws_vpc" "default" {
  default = true
}
#this retrieves the default vpc

resource "aws_instance" "jenkins_instance"
ami = "ami-051f7e7f6c2f40dc1"
