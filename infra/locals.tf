locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.vpc_qtd_azs)

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.name
  }
}