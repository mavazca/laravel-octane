resource "aws_lb" "LB" {
  name               = "LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG.id]
  subnets            = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]

  tags = {
    Name = "LB"
  }
}

resource "aws_lb_listener" "LISTENER" {
  load_balancer_arn = aws_lb.LB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}