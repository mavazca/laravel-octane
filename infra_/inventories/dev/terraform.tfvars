environment = "dev"
domain_name       = "dev.kishop.com.br"
subdomain_wildcard = "*.dev.kishop.com.br"

region = "us-east-1"
instance_type = "t2.micro" // Tipo de instância Free Tier
min_size = 1
max_size = 1
desired_capacity = 1

vpc_cidr = "10.1.0.0/16"
vpc_azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
vpc_public_subnets = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

project_tags = {
  Terraform   = "true"
  Environment = "dev"
  Project     = "Laravel Octane"
}

ssm_parameters = {
  APP_NAME = "Laravel Octane"
  APP_ENV = "local"
  APP_KEY = "base64:JwUZJBq/SIQAo/uXblQY783b4etZobCcSEd2TyvsYQE="
  APP_DEBUG = "true"
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
