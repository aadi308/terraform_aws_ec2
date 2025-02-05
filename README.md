# Terraform VPC and EC2 Instance Module

## Overview
This Terraform module creates a simple AWS infrastructure that includes:
- A Virtual Private Cloud (VPC)
- A public and private subnet
- An Internet Gateway (IGW)
- A Route Table for the public subnet
- A Security Group to allow SSH access
- A `t2.micro` EC2 instance in the public subnet

---

## Prerequisites
1. Terraform installed on your system. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
2. AWS CLI configured with the necessary credentials.
3. An existing key pair in your AWS account.
   - The key pair name must be passed as the `key_name` variable.
   - Example: If your key pair is named `my-key-pair`, pass it to Terraform.

---

## Usage

### Clone the Repository
```bash
git clone https://github.com/aadi308/terraform_aws_ec2.git  
cd terraform_aws_ec2
```

### Initialize Terraform
```bash
terraform init
```

### Plan the Infrastructure
```bash
terraform plan 
```

### Apply the Infrastructure
```bash
terraform apply 
```
### Apply no. of instance 
```
terraform apply -var="instance_count=3"
```

### Destroy the Infrastructure
```bash
terraform destroy 
```

---

### SSH into EC2 Instance
Once your EC2 instance is up and running, follow these steps to SSH into the instance:

1. Navigate to the directory where your key file is saved (e.g., `Downloads/`).

2. Change the permissions of the key file to be read-only:

   ```bash
   chmod 400 <your-key-pair-name>.pem
   ```
   
3. SSH into your EC2 instance using the public IP address of the instance:
   
   ```bash
   ssh -i <your-key-pair-name>.pem ec2-user@<ec2-public-ip>
   ````


**Note:** Ensure that your AWS account has the necessary permissions to create the resources (VPC, EC2, Security Groups, etc.) in the region you are working in.