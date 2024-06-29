// Configuração de lançamento para Auto Scaling Group
resource "aws_launch_configuration" "ecs_launch_configuration" {
  name              = "${var.environment}-${var.app_name}-lc"
  image_id          = "ami-0195204d5dce06d99"  // Substitua pela AMI apropriada
  instance_type     = var.instance_type
  security_groups   = [aws_security_group.SG.id]

  lifecycle {
    create_before_destroy = true
  }
}

// Grupo de Auto Scaling que gerencia as instâncias baseadas na configuração de lançamento
resource "aws_autoscaling_group" "aws_autoscaling_group" {
  launch_configuration = aws_launch_configuration.ecs_launch_configuration.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = module.vpc.public_subnets
}
