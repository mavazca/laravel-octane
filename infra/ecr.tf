################################################################################
# ECR Repository
################################################################################

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.2.1"

  repository_name = "${var.environment}-${var.name}-repository"

  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  create_lifecycle_policy           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Mantenha as últimas 10 imagens",
        selection = {
          tagStatus     = "tagged",
          countType     = "imageCountMoreThan",
          countNumber   = 10,
          tagPrefixList = ["latest", "release", "prod", "dev"]
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.name
  }
}