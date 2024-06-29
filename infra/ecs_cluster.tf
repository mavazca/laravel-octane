################################################################################
# ECS Cluster
################################################################################

/// Cria um cluster ECS para gerenciar contêineres
resource "aws_ecs_cluster" "ECS" {
  name = "${var.environment}-${var.name}-cluster-ecs"

  tags = local.tags
}

// Cria um grupo de logs do CloudWatch para o ECS
resource "aws_cloudwatch_log_group" "ECS_LOG_GROUP" {
  name              = "/ecs/${var.environment}-${var.name}"
  retention_in_days = 30

  tags = local.tags
}
