resource "aws_ecs_service" "ECS_SERVICE" {
  name            = "laravel-octane-service"
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  cluster         = aws_ecs_cluster.ECS.id
  task_definition = aws_ecs_task_definition.TD.arn
  scheduling_strategy = "REPLICA"
  desired_count   = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
    security_groups  = [aws_security_group.SG.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = "laravel-octane-container"
    container_port   = 80
  }

  depends_on = [
    aws_ecs_cluster.ECS,
    aws_ecr_repository.ECR,
    aws_lb.LB,
    aws_lb_listener.LISTENER,
  ]
}