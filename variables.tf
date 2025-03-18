# Variables for VPC and other resources
variable "region" {
  type        = string
  description = "AWS region"
}

variable "profile" {
  type        = string
  description = "AWS profile"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
}

variable "private_subnet_count" {
  type        = number
  description = "Number of public subnets to create"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "public_route" {
  type        = string
  description = "Public route"
}

variable "az_state" {
  type        = string
  description = "State of availability zones"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy of the instance"
  default     = "default"
}

variable "app_port" {
  type        = number
  description = "Custom Application port"
}

variable "ssh_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for SSH access"
}

variable "http_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for HTTP access"
}

variable "https_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for HTTPS access"
}

variable "app_port_cidr" {
  type        = list(string)
  description = "CIDR blocks for Application port access"
}

variable "custom_ami_id" {
  type        = string
  description = "Custom AMI ID"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "volume_size" {
  type        = number
  description = "Volume size"
}

variable "volume_type" {
  type        = string
  description = "Volume type"
}

variable "delete_on_termination" {
  type        = bool
  description = "Delete on termination"
}

variable "disable_api_termination" {
  type        = bool
  description = "Disable API termination"
}

variable "target_subnet_index" {
  type        = number
  description = "Index of the target subnet"
  default     = 0
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "rds_name" {
  type        = string
  description = "RDS name"
}

variable "rds_username" {
  type        = string
  description = "RDS username"
}

variable "rds_engine" {
  type        = string
  description = "RDS engine"
}

variable "rds_engine_version" {
  type        = string
  description = "RDS engine version"
}

variable "rds_allocated_storage" {
  type        = number
  description = "RDS allocated storage"
}

variable "rds_storage_type" {
  type        = string
  description = "RDS storage type"
}

variable "s3_encryption_algorithm" {
  type        = string
  description = "S3 encryption algorithm"
}

variable "s3_transition_days" {
  type        = number
  description = "S3 transition days"
}

variable "s3_transition_storage_class" {
  type        = string
  description = "S3 transition storage class"
}