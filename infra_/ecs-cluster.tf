// Cria um cluster ECS para gerenciar contêineres
resource "aws_ecs_cluster" "ECS" {
  name = "ecs-cluster-${var.environment}-${var.app_name}"

  tags = var.project_tags
}

// Cria um grupo de logs do CloudWatch para o ECS
resource "aws_cloudwatch_log_group" "ECS_LOG_GROUP" {
  name              = "/ecs/${var.environment}-${var.app_name}"
  retention_in_days = 30

  tags = var.project_tags
}
