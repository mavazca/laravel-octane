variable "region" {
  description = "Região usada para criar os recursos da AWS"
  type        = string
  nullable        = false
}

variable "environment" {
  description = "Ambiente da aplicação"
  type = string
}

variable "domain_name" {
  description = "O nome do domínio principal"
  type        = string
  nullable    = false
}

variable "subdomain_wildcard" {
  description = "O domínio curinga para subdomínios"
  type        = string
  nullable    = false
}

variable "app_name" {
  description = "Nome da aplicação"
  type = string
  default = "laravel-octane"
}

variable "ssm_parameters" {
  description = "Parâmetros do SSM"
  type = map(string)
}

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

variable "max_size" {
  description = "Número máximo de instâncias"
  type    = number
  default = 1
}

variable "min_size" {
  description = "Número mínimo de instâncias"
  type    = number
  default = 1
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type    = string
  nullable    = false
}

variable "vpc_azs" {
  description = "Zonas de disponibilidade da VPC"
  type    = set(string)
  nullable    = false
}

variable "vpc_private_subnets" {
  description = "Subnets privadas da VPC"
  type    = set(string)
  nullable    = false
}

variable "vpc_public_subnets" {
  description = "Subnets publicas da VPC"
  type    = set(string)
  nullable    = false
}

variable "project_tags" {
  description = "Tags do projeto"
  type        = map(any)
  nullable    = false
}

variable "secure_parameters" {
  description = "Lista de parâmetros que devem ser armazenados como SecureString"
  type        = list(string)
  default     = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY", "DB_PASSWORD"]
}

