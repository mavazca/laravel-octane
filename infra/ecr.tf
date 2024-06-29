resource "aws_ecr_repository" "ECR" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
}
