################################################################################
# RDS module
################################################################################

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.7.0"

  identifier = "${local.name}-mysql-rds"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  manage_master_user_password = false

  db_name  = local.db_database
  username = local.db_username
  password = local.db_password
  port     = 3306

  multi_az = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 7

  skip_final_snapshot = true
  deletion_protection = false

  publicly_accessible = true

  tags = local.tags
}

################################################################################
# Security group module
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.name}-mysql-sg"
  description = "MySQL security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "Acesso MySQL de dentro do VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      rule        = "mysql-tcp"
      description = "Acesso MySQL para Internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = local.tags
}

################################################################################
# VPC module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs              = local.azs
  public_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 6)]

  // Acesso público às instâncias do RDS (não é recomendado para produção) especificando estes argumentos:
  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}