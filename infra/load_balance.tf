################################################################################
# Load Balancer
################################################################################

// Cria um balanceador de carga para distribuir o tráfego para as instâncias
resource "aws_lb" "LB" {
  name               = "${var.environment}-${var.name}-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG.id]
  subnets            = module.vpc.public_subnets

  tags = local.tags
}

// Cria um listener HTTP para o balanceador de carga que redireciona para HTTPS
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}
