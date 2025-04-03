# Variables for VPC and other resources
variable "environment" {
  type        = string
  description = "Environment name (e.g., dev1, dev2, prod)"
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

variable "egress_cidr" {
  type        = list(string)
  description = "CIDR blocks for egress access"
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

variable "region" {
  type        = string
  description = "AWS region"
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

variable "asg_max_capacity" {
  type        = number
  description = "Auto Scaling Group maximum capacity"
}

variable "asg_min_capacity" {
  type        = number
  description = "Auto Scaling Group minimum capacity"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Auto Scaling Group desired capacity"
}

variable "asg_cooldown_period" {
  type        = number
  description = "Auto Scaling Group cooldown period in seconds"
}

variable "asg_grace_period" {
  type        = number
  description = "Auto Scaling Group health check grace period in seconds"
}

variable "alb_health_check_path" {
  type        = string
  description = "ALB health check path"
}

variable "asg_scale_up_adjustment" {
  type        = number
  description = "Scaling adjustment for scaling up the Auto Scaling Group"
}

variable "asg_scale_down_adjustment" {
  type        = number
  description = "Scaling adjustment for scaling down the Auto Scaling Group"
}

variable "asg_scale_up_threshold" {
  type        = number
  description = "Threshold for scaling up the Auto Scaling Group"
}

variable "asg_scale_down_threshold" {
  type        = number
  description = "Threshold for scaling down the Auto Scaling Group"
}

variable "zone_name" {
  type        = string
  description = "Route53 zone name"
}