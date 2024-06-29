################################################################################
# S3
################################################################################

// Cria um bucket S3 para armazenar dados da aplicação
resource "aws_s3_bucket" "S3" {
  bucket = "${var.environment}-${var.name}-s3"

  tags = local.tags
}
