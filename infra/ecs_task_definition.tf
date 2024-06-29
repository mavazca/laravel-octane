################################################################################
# ECS Task Definition
################################################################################

// Define a tarefa ECS que será executada no serviço ECS
resource "aws_ecs_task_definition" "TD" {
  family                   = "${var.environment}-${var.name}-task-definition"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ECS_TASK_EXECUTION_ROLE.arn
  network_mode             = "awsvpc"
  cpu                      = "512"  // 0.5 vCPU
  memory                   = "1024" // 1 GiB de memória

  container_definitions = jsonencode([
    {
      name  = "${var.environment}-${var.name}-container",
      image = "nginx:latest",
      #image = "${aws_ecr_repository.ECR.repository_url}:latest", // image = "nginx:latest",
      cpu          = 512,   // 0.5 vCPU
      memory       = 1024,  // 1 GiB de memória
      essential    = true,
      portMappings = [{ containerPort = 80, hostPort = 80 }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ECS_LOG_GROUP.name,
          "awslogs-region"        = var.region,
          "awslogs-stream-prefix" = "ecs"
        }
      },
      environment = [
        for key, value in var.ssm_parameters :
        {
          name = key,
          valueFrom = "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.environment}/${key}"
        }
      ]
    }
  ])
}
