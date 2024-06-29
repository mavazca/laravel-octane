resource "aws_lb_target_group" "TG" {
  name     = "tg-${var.environment}-${var.app_name}"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = module.vpc.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = var.project_tags
}