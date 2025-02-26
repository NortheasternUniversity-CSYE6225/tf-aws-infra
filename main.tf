module "vpc" {
  source = "./modules"

  environment             = var.environment
  vpc_cidr                = var.vpc_cidr
  public_subnet_count     = var.public_subnet_count
  private_subnet_count    = var.private_subnet_count
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  public_route            = var.public_route
  az_state                = var.az_state
  instance_tenancy        = var.instance_tenancy
  app_port                = var.app_port
  ssh_port_cidr           = var.ssh_port_cidr
  http_port_cidr          = var.http_port_cidr
  https_port_cidr         = var.https_port_cidr
  app_port_cidr           = var.app_port_cidr
  custom_ami_id           = var.custom_ami_id
  volume_size             = var.volume_size
  volume_type             = var.volume_type
  delete_on_termination   = var.delete_on_termination
  disable_api_termination = var.disable_api_termination
  ec2_instance_type       = var.ec2_instance_type
  target_subnet_index     = var.target_subnet_index
}