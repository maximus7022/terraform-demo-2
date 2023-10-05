variable "vpc_id" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "tg_name" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}
