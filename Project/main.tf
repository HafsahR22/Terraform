provider "aws" {
  region = "us-east-1"
}
data "aws_vpc" "default" {               
  default = true
}

resource "aws_instance" "jenkins_instance" {
  ami           = "ami-051f7e7f6c2f40dc1"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
 

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y java-1.8.0-openjdk-devel
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              sudo yum install -y jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF

  tags = {
    Name = "JenkinsInstance"
  }
}

resource "aws_security_group" "jenkins_security_group" {
  name_prefix = "jenkins-"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["5.107.50.69/32"]  # Replace with your IP address
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all for demonstration purposes; make more restrictive in production
  }
}


resource "aws_s3_bucket" "jenkins_artifacts_bucket" {
  bucket = "jenkins-artifacts-bucket-example"
  acl    = "private"

  versioning {
    enabled = true
  }
}