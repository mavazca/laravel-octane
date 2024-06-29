// Cria um bucket S3 para armazenar dados da aplicação
resource "aws_s3_bucket" "S3" {
  bucket = "s3-${var.environment}-${var.app_name}"

  tags = var.project_tags
}
