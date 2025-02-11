variable "aws_region" {
  default = "us-east-1"
  description = "AWS region for deployment"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
  description = "CIDR block for the VPC"
}

# variable "public_subnet_cidr" {
#   default = "10.0.1.0/24"
#   description = "CIDR block for the public subnet"
# }

# variable "private_subnet_cidr" {
#   default = "10.0.2.0/24"
#   description = "CIDR block for the private subnet"
# }

variable "availability_zone" {
  default = "us-east-1a"
  description = "Availability zone for the subnets"
}

variable "ami_id" {
  default = "ami-04b4f1a9cf54c11d0"
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  default = "t2.2xlarge"
  description = "Instance type for the EC2 instance"
}

variable "key_name" {
  default     = "aadi"
  description = "Key pair name to use for the EC2 instance"
}
