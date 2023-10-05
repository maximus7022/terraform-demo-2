resource "aws_lb_target_group" "laravel_tg" {
  name        = var.tg_name
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = var.lb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "laravel_listener" {
  load_balancer_arn = var.lb_arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.laravel_tg.arn
    type             = "forward"
  }
}
