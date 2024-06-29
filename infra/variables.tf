variable "region" {
  description = "Região usada para criar os recursos da AWS"
  type        = string
  default     = "us-east-1"
}

################################################################################
# PROJECT
################################################################################

variable "environment" {
  description = "Ambiente da aplicação"
  type = string
  default = "dev"
}

variable "name" {
  description = "Nome da aplicação"
  type = string
  default = "laravel-octane"
}

################################################################################
# ECS
################################################################################

variable "instance_type" {
  description = "Tipo de instância"
  type    = string
  default = "t2.micro" // Tipo de instância Free Tier
}

variable "desired_capacity" {
  description = "Número desejado de instâncias"
  type    = number
  default = 1
}

variable "min_size" {
  description = "Número mínimo de instâncias"
  type    = number
  default = 1
}

variable "max_size" {
  description = "Número máximo de instâncias"
  type    = number
  default = 1
}

################################################################################
# DB
################################################################################

variable "db_database" {
  description = "Nome do banco de dados"
  type    = string
  default = "laravel"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type    = string
  default = "admin"
}

variable "db_password" {
  description = "Senha do banco de dados (mínimo 8 caracteres)"
  type    = string
  default = "12345678"
}

variable "db_ingress_with_internet" {
  description = "Lista de regras de ingresso com acesso à Internet"
  type = list(any)
  default = []
}

################################################################################
# VPC
################################################################################

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_qtd_azs" {
  description = "Quantidade de Availability Zones da VPC"
  type    = number
  default = 2
}

################################################################################
# SSM
################################################################################

variable "ssm_parameters" {
  description = "Parâmetros do SSM"
  type = map(string)
}

variable "secure_parameters" {
  description = "Lista de parâmetros que devem ser armazenados como SecureString"
  type        = list(string)
  default     = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "DB_PASSWORD"]
}

