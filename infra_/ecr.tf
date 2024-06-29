// Repositório ECR para armazenar imagens Docker
resource "aws_ecr_repository" "ECR" {
  name                 = "${var.environment}-${var.app_name}-repository"
  image_tag_mutability = "MUTABLE"

  tags = var.project_tags
}
