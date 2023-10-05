output "rds_hostname" {
  value = aws_db_instance.rds.address
}

output "rds_password" {
  value = random_password.password.result
}
