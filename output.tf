output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "The ID of the public subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
  description = "The ID of the private subnet"
}

output "ec2_instance_public_ips" {
  value       = aws_instance.public_instance[*].public_ip
  description = "The public IPs of the EC2 instances"
}

output "ec2_instance_ids" {
  value       = aws_instance.public_instance[*].id
  description = "The IDs of the EC2 instances"
}
