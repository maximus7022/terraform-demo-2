module "backend" {
  source      = "./modules/backend"
  bucket_name = var.bucket_name
  dynamo_name = var.dynamo_name
}

module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  env                  = var.env
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.repository_name
}

module "jenkins" {
  source    = "./modules/jenkins"
  vpc_id    = module.network.vpc_id
  vpc_cidr  = var.vpc_cidr
  subnet_id = module.network.private_subnet_ids[0]
}

module "load_balancer" {
  source          = "./modules/alb"
  vpc_id          = module.network.vpc_id
  lb_name         = var.lb_name
  tg_name         = var.tg_name
  subnets         = module.network.public_subnet_ids
  instance_id     = module.jenkins.instance_id
  certificate_arn = module.https.certificate_arn
}

module "ecs" {
  source             = "./modules/ecs"
  app_name           = var.app_name
  env                = var.env
  app_port           = var.app_port
  ecr_repository_url = module.ecr.ecr_repository_url
  image_tag          = var.image_tag
  lb_arn             = module.load_balancer.lb_arn
  private_subnet_ids = module.network.private_subnet_ids
  vpc_id             = module.network.vpc_id
  vpc_cidr           = var.vpc_cidr
  certificate_arn    = module.https.certificate_arn
}

module "rds" {
  source        = "./modules/rds"
  db_name       = local.db_name
  db_identifier = local.db_identifier
  username      = var.username
  vpc_id        = module.network.vpc_id
  vpc_cidr      = var.vpc_cidr
  subnet_ids    = module.network.private_subnet_ids
}

module "https" {
  source       = "./modules/https"
  domain       = var.domain
  alb_dns_name = module.load_balancer.lb_dns_name
  alb_zone_id  = module.load_balancer.lb_zone_id
}
