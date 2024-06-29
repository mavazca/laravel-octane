resource "aws_ecs_cluster" "ECS" {
  name = "ecs-cluster-laravel-octane"

    tags = {
        Name = "ecs-cluster-laravel-octane"
    }
}

resource "aws_cloudwatch_log_group" "ECS_LOG_GROUP" {
  name              = "/ecs/laravel-octane"
  retention_in_days = 30

    tags = {
        Name = "cloudwatch-log-group-laravel-octane"
    }
}