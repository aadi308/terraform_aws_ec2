variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "name_tags" {
  description = "List of names for the EC2 instances"
  type        = list(string)
  default     = ["Chat-Server", "Chat-Client-1", "Chat-Client-2", "Chat-Client-3"]
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MYVPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "MYIGW"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 1, 0)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 1, 1)
  availability_zone = var.availability_zone
  tags = {
    Name = "Private-Subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Instance-SG"
  }
}

resource "aws_instance" "public_instance" {
  count          = var.instance_count
  ami            = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = aws_subnet.public.id
  key_name       = var.key_name

  vpc_security_group_ids = [
    aws_security_group.instance_sg.id
  ]

  user_data = <<-EOF
    #!/bin/bash
    # Download and extract Go
    wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz

    # Update apt repositories
    apt-get update

    # Optionally install vim (if needed)
    apt-get install -y vim

    # Append environment variables to /etc/profile
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
    echo "export GOPATH=\$HOME/go" >> /etc/profile
    echo "export PATH=\$PATH:\$GOPATH/bin" >> /etc/profile
    echo "export GO111MODULE=off" >> /etc/profile

    # Source the profile so the variables are available immediately
    source /etc/profile
  EOF
  
  tags = {
    Name = length(var.name_tags) > count.index ? var.name_tags[count.index] : "ec2-instance-${count.index + 1}"
  }
}
