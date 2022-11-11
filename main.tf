terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.private_key.public_key_openssh
}

data "http" "myip" {
  url = "https://api.ipify.org"
}

# the public_ip of my gw
locals {
  myip = "${data.http.myip.response_body}/32"
}

resource "random_pet" "pet" {
  length = 1
}

resource "aws_security_group" "instances" {
  name   = "${var.security_group_name}-${random_pet.pet.id}_${terraform.workspace}"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # opening port 22 to be able to ssh to the instances
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block, local.myip]
  }
  # provide internet access to the instance (install packages, etc)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  ami                    = var.ami
  instance_type          = var.server_instance_type
  vpc_security_group_ids = [aws_security_group.instances.id]
  key_name               = aws_key_pair.generated_key.key_name
  root_block_device {
    volume_size = 100
    volume_type = "io1"
    iops        = 1000
  }
  user_data = templatefile("cloudinit_server.yaml", {
    record-fqdn = var.record_name,
    email       = var.email
  })
  tags = {
    Name = "server_${random_pet.pet.id}_${terraform.workspace}"
  }
}
data "aws_route53_zone" "base_domain" {
  name = var.hosted_zone_name
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.base_domain.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.server.public_ip]
}
