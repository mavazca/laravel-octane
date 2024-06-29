region = "us-east-1"

################################################################################
# PROJECT
################################################################################

environment = "prod"
name = "laravel-octane"

################################################################################
# ECS
################################################################################

instance_type = "t2.micro"
desired_capacity = 1
min_size = 1
max_size = 2

################################################################################
# DB
################################################################################

db_database = "laravel"
db_username = "admin"
db_password = "12345678"

################################################################################
# VPC
################################################################################

vpc_cidr  = "10.0.0.0/16"
vpc_qtd_azs = 2

################################################################################
# SSM
################################################################################

ssm_parameters = {
  APP_NAME = "Laravel Octane"
  APP_ENV = "production"
  APP_KEY = "base64:JwUZJBq/SIQAo/uXblQY783b4etZobCcSEd2TyvsYQE="
  APP_DEBUG = "false"
  APP_URL = "http://localhost"

  APP_TIMEZONE = "UTC"
  APP_LOCALE = "en"
  APP_FAKER_LOCALE = "en_US"

  DB_CONNECTION = "mysql"
  DB_HOST = "dev-db-host"
  DB_PORT = "3306"
  DB_DATABASE = "dev-db-name"
  DB_USERNAME = "dev-db-user"
  DB_PASSWORD = "dev-db-password"

  MAIL_HOST = "127.0.0.1"
  MAIL_PORT = "2525"
  MAIL_USERNAME = "null"
  MAIL_PASSWORD = "null"
  MAIL_ENCRYPTION = "null"
  MAIL_FROM_ADDRESS = "hello@example.com"

  AWS_ACCESS_KEY_ID = "your-access-key-id"
  AWS_SECRET_ACCESS_KEY = "your-secret-access-key"
  AWS_DEFAULT_REGION = "us-east-1"
  AWS_BUCKET = "your-bucket-name"
}