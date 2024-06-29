// Define um serviço ECS para executar tarefas no cluster ECS
resource "aws_ecs_service" "ECS_SERVICE" {
  name                  = "${var.environment}-${var.app_name}-service"
  cluster               = aws_ecs_cluster.ECS.id
  task_definition       = aws_ecs_task_definition.TD.arn
  desired_count         = var.desired_capacity
  launch_type           = "FARGATE"
  scheduling_strategy   = "REPLICA"

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.SG.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = "${var.environment}-${var.app_name}-container"
    container_port   = 80
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  depends_on = [
    aws_ecs_cluster.ECS,
    aws_lb_listener.http_listener,
    aws_lb_listener.https_listener,
  ]
}
