module "vpc" {

  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  route-for-public-rt = var.route-for-public-rt

}

module "ec2" {

  source    = "./modules/ec2"
  ami       = var.ami
  vpcid     = module.vpc.vpcid
  subnet_id = module.vpc.public_subnet_ids
  elb_security_group_id = module.elb.elb_security_group_id


}

module "rds" {

  source              = "./modules/rds"
  subnet_id           = module.vpc.public_subnet_ids
  private_subnet_name = module.vpc.private_subnet_name
  vpcid               = module.vpc.vpcid
  sec-group-id        = module.ec2.sec-group-id
  username            = var.username
  password            = var.password
  availability_zone   = module.vpc.az
  private_subnet_ids  = module.vpc.private_subnet_ids

}

module "elb" {

  source            = "./modules/elb"
  vpcid             = module.vpc.vpcid
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2-id            = module.asg.ec2-id

}

module "asg" {

  source = "./modules/asg"
  ami = var.ami
  aws_key_name = module.ec2.aws_key_name
  sec-group-id = module.ec2.sec-group-id
  private_subnet_ids = module.vpc.private_subnet_ids
  aws_lb_target_group_arn = module.elb.aws_lb_target_group
  
}