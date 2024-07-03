locals {
  name   = "laravel-octane"
  region = "us-east-1"

  environment = "dev"

  db_database = "laravel"
  db_username = "laravel"
  db_password = "12341234" # No mínimo 8 caracteres

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Terraform   = "true"
    Environment = local.environment
    Project     = local.name
  }
}