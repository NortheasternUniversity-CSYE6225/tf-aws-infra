# tf-aws-infra

## Description
This repository demonstrates AWS VPC networking setup using Terraform.

## Prerequisites
- AWS CLI configured with appropriate credentials
- Terraform installed (v1.0.0 or newer)

## Run command to import the certificate into ACM
```bash
    aws acm import-certificate \
    --certificate fileb://demo_shreyaspurkar_me.crt \
    --private-key fileb://demo.shreyaspurkar.me.key \
    --certificate-chain fileb://demo_shreyaspurkar_me.ca-bundle \
    --region us-east-2
```

To check the versions installed:
```bash
  terraform --version
```
## Infrastructure Configuration Instructions
### 1. Clone the Repository
```angular2html
git clone git@github.com:NortheasternUniversity-CSYE6225/tf-aws-infra.git
```

### 2. Initialize Terraform
```bash
    terraform init
```

### 3. Format Terraform
```bash
    terraform fmt
```

### 4. Validate Terraform
```bash
    terraform validate
```

### 5. Plan Terraform
```bash
    terraform plan 
```

### 6. Apply Terraform
```bash
    terraform apply
```

## Cleanup Resources
Cleanup the resources after use
```bash
    terraform destroy
```

## Troubleshooting
#### If you encounter issues during the setup process:
 - Ensure all dependencies are installed.
 - Ensure environment variables are setup.