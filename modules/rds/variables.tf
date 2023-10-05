variable "host_secret_name" {
  type    = string
  default = "rds-host-2"
}
variable "database_secret_name" {
  type    = string
  default = "rds-database-2"
}

variable "username_secret_name" {
  type    = string
  default = "rds-username-2"
}

variable "password_secret_name" {
  type    = string
  default = "rds-password-2"
}

variable "subnet_name" {
  type    = string
  default = "rds-subnet-group"
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_name" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "storage" {
  default = 10
}

variable "username" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
