resource "aws_ecs_task_definition" "TD" {
  family                   = "laravel-octane"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ECS_TASK_EXECUTION_ROLE.arn
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name  = "laravel-octane-container",
      image = "nginx:latest",
      # image        = aws_ecr_repository.ECR.repository_url,
      cpu          = 256,
      memory       = 512,
      essential    = true,
      portMappings = [{ containerPort = 80, hostPort = 80 }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ECS_LOG_GROUP.name,
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

data "aws_ecs_task_definition" "TD" {
  task_definition = aws_ecs_task_definition.TD.family
}