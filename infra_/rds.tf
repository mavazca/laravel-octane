// Cria uma instância RDS MySQL para o banco de dados da aplicação
resource "aws_db_instance" "RDS" {
  identifier             = "${var.environment}-${var.app_name}-rds"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.ssm_parameters["DB_DATABASE"]
  username               = var.ssm_parameters["DB_USERNAME"]
  password               = var.ssm_parameters["DB_PASSWORD"]
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true

  vpc_security_group_ids = [aws_security_group.SG.id]

  tags = var.project_tags

  depends_on = [module.vpc]
}
