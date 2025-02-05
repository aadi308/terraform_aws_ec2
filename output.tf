output "vpc_id" {
  value = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value = aws_subnet.private.id
  description = "The ID of the private subnet"
}

# output "ec2_instance_public_ip" {
#   value = aws_instance.public_instance.public_ip
#   description = "The public IP of the EC2 instance"
# }

# output "ec2_instance_id" {
#   value = aws_instance.public_instance.id
#   description = "The ID of the EC2 instance"
# }

output "ec2_instance_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = [for instance in aws_instance.public_instance : instance.public_ip]
}

output "ec2_instance_ids" {
  description = "IDs of EC2 instances"
  value       = [for instance in aws_instance.public_instance : instance.id]
}
