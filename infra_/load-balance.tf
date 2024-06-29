// Cria um balanceador de carga para distribuir o tráfego para as instâncias
resource "aws_lb" "LB" {
  name               = "${var.environment}-${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG.id]
  subnets            = module.vpc.public_subnets

  tags = var.project_tags
}

// Cria um listener HTTP para o balanceador de carga que redireciona para HTTPS
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

// Cria um listener HTTPS para o balanceador de carga
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.LB.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}
