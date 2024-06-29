################################################################################
# RDS
################################################################################

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.7.0"

  identifier = "${var.name}-mysql-rds"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  manage_master_user_password = false

  db_name  = var.db_database
  username = var.db_username
  password = var.db_password
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
# RDS Security group
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.name}-mysql-sg"
  description = "MySQL security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = concat(
    [
      {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        description = "Acesso MySQL de dentro do VPC"
        cidr_blocks = module.vpc.vpc_cidr_block
      }
    ],
    var.db_ingress_with_internet
  )

  tags = local.tags
}