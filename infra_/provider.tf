// Define os provedores e o backend do Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
  backend "s3" {}
}

// Configura o provedor AWS para usar a região especificada
provider "aws" {
  region = var.region
}

// Obtém informações sobre o usuário atual da AWS
data "aws_caller_identity" "current" {}
