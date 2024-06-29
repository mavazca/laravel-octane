################################################################################
# Load Balancer Target Group
################################################################################

resource "aws_lb_target_group" "TG" {
  name     = "${var.environment}-${var.name}-target-group"
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

  tags = local.tags
}