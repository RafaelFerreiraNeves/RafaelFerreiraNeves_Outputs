module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
}

module "ec2" {
  source = "./modules/ec2"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
}
