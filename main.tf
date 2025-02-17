module "vpc" {
  source = "./modules"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_route         = var.public_route
  az_state             = var.az_state
  instance_tenancy     = var.instance_tenancy
}