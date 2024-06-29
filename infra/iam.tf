resource "aws_iam_role" "ECS_TASK_EXECUTION_ROLE" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_trust_relationship.json
}

data "aws_iam_policy_document" "ecs_tasks_trust_relationship" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ECS_TASK_EXECUTION_ROLE_POLICY" {
  role       = aws_iam_role.ECS_TASK_EXECUTION_ROLE.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "CLOUDWATCH_LOGS_POLICY" {
  role       = aws_iam_role.ECS_TASK_EXECUTION_ROLE.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}