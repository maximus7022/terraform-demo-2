variable "taskdef_template" {
  default = "./modules/ecs/app.json.tpl"
}

variable "app_name" {
  type = string
}

variable "env" {
  type = string
}

variable "app_port" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "app_count" {
  default = 1
}

variable "lb_arn" {
  type = string
}

variable "tg_name" {
  type    = string
  default = "laravel-tg"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "certificate_arn" {
  type = string
}

locals {
  app_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
  env_vars = [
    {
      "name" : "VERSION",
      "value" : "${var.image_tag}"
    }
  ]
}

