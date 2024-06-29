################################################################################
# VPC
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.environment}-${var.name}-vpc"
  cidr = var.vpc_cidr

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 6)]

  // Acesso público às instâncias do RDS (não é recomendado para produção) especificando estes argumentos:
  create_database_subnet_group           = (var.environment == "dev" ? true : false)
  create_database_subnet_route_table     = (var.environment == "dev" ? true : false)
  create_database_internet_gateway_route = (var.environment == "dev" ? true : false)

  tags = local.tags
}
