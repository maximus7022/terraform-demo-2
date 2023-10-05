resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-${var.env}-cluster"
}

data "template_file" "app" {
  template = file(var.taskdef_template)

  vars = {
    app_name  = var.app_name
    env       = var.env
    app_port  = var.app_port
    image_tag = var.image_tag
    app_image = local.app_image
    env_vars  = jsonencode(local.env_vars)
  }
}

resource "aws_ecs_task_definition" "task_def" {
  family                   = "${var.app_name}-${var.env}-td"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions    = data.template_file.app.rendered
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-${var.env}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_def.arn
  launch_type     = "FARGATE"
  desired_count   = var.app_count

  network_configuration {
    security_groups  = [aws_security_group.ecs_service_sg.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.laravel_tg.arn
    container_name   = "${var.app_name}-${var.env}-app"
    container_port   = var.app_port
  }

  depends_on = [aws_lb_listener.laravel_listener]
}
