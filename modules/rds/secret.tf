
# ===============DB_HOSTNAME==================

resource "aws_secretsmanager_secret" "host" {
  name = var.host_secret_name
}

resource "aws_secretsmanager_secret_version" "host" {
  secret_id     = aws_secretsmanager_secret.host.id
  secret_string = aws_db_instance.rds.address
}

# ===============DB_DATABASE==================

resource "aws_secretsmanager_secret" "database" {
  name = var.database_secret_name
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id     = aws_secretsmanager_secret.database.id
  secret_string = var.db_name
}

# ===============DB_USERNAME==================

resource "aws_secretsmanager_secret" "username" {
  name = var.username_secret_name
}

resource "aws_secretsmanager_secret_version" "username" {
  secret_id     = aws_secretsmanager_secret.username.id
  secret_string = var.username
}

# ===============DB_PASSWORD==================

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = var.password_secret_name
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.password.id
  secret_string = random_password.password.result
}
