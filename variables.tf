
variable "region" {
  default = "eu-north-1"
}

# ===================BACKEND=======================

variable "bucket_name" {
  type    = string
  default = "tf-rmt-state-s3-bucket"
}

variable "dynamo_name" {
  type    = string
  default = "dydb-terraform-state-lock"
}

# ===================NETWORK=======================

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.2.0/24",
    "10.0.4.0/24"
  ]
}

# ===================ECR=======================

variable "repository_name" {
  default = "laravel-app-ecr-repo"
}

# ===================ALB=======================

variable "lb_name" {
  default = "laravel-demo-lb"
}

variable "tg_name" {
  default = "jenkins-tg"
}

# ===================ECS=======================

variable "app_name" {
  default = "laravel"
}

variable "app_port" {
  default = 5000
}

variable "image_tag" {
  default = "latest"
}

# ===================RDS=======================
locals {
  db_name       = format("%sDB", var.app_name)
  db_identifier = "${var.app_name}-${var.env}-db"
}

variable "username" {
  default = "admin"
}

# ===================HTTPS=======================
variable "domain" {
  default = "max-pash.pp.ua"
}
