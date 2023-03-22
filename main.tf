provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "webportal" {
  ami = "ami-25488752"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.ssh_http.name]
  user_data              = file("web_template/home_page.sh")
  count         = var.instance_count
}

resource "aws_security_group" "ssh_http" {
  name        = "ssh_http"
  description = "Allow SSH and HTTP"

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