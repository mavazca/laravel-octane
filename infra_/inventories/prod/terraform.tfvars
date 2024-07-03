environment = "prod"
domain_name       = "kishop.com.br"
subdomain_wildcard = "*.kishop.com.br"

region = "us-east-1"
desired_capacity = 2
min_size = 2
max_size = 3

vpc_cidr = "10.0.0.0/16"
vpc_azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

project_tags = {
  Terraform   = "true"
  Environment = "prod"
  Project     = "Laravel Octane"
}

ssm_parameters = {
  APP_NAME = "Laravel Octane"
  APP_ENV = "production"
  APP_KEY = "prod-app-key"
  APP_DEBUG = "false"
  APP_URL = "http://localhost"
  APP_TIMEZONE = "UTC"
  APP_LOCALE = "en"
  APP_FAKER_LOCALE = "en_US"
  DB_CONNECTION = "mysql"
  DB_HOST = "prod-db-host"
  DB_PORT = "3306"
  DB_DATABASE = "prod-db-name"
  DB_USERNAME = "prod-db-user"
  DB_PASSWORD = "prod-db-password"
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
