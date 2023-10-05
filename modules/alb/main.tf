resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demo_lb_sg.id]
  subnets            = var.subnets
}

resource "aws_lb_target_group" "jenkins_tg" {
  name     = var.tg_name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "jenkins_tg" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = var.instance_id
  port             = 8080
}

resource "aws_lb_listener" "jenkins_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 8080
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
    type             = "forward"
  }
}
