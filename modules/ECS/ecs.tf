resource "aws_ecs_cluster" "suvi-tf-ecs-cluster" {
  name = "suvi-tf-ecs-cluster"  
}

resource "aws_ecs_task_definition" "suvi-tf-task" {
  family                   = "suvi-tf-task"  
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"   
  memory = "512"

  execution_role_arn = aws_iam_role.suvi-tf-ecs-task-execution-role.arn

  container_definitions = <<EOF
[
  {
    "name": "web-app-container",
    "image": "${var.ecr-url}:latest",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 80
      }
    ]
  }
]
EOF
}

resource "aws_ecs_service" "suvi-tf-app-service" {
  name            = "suvi-tf-app-service"  
  cluster         = aws_ecs_cluster.suvi-tf-ecs-cluster.id
  task_definition = aws_ecs_task_definition.suvi-tf-task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [var.ecs-subnet1-id, var.ecs-subnet2-id]  
    security_groups = [var.sg-id]  
  }

  depends_on = [var.lb-arn]

  load_balancer {
    target_group_arn = var.tg-arn
    container_name = "webapp"
    container_port = 5000
    }
}

resource "aws_iam_role" "suvi-tf-ecs-task-execution-role" {
  name = "ecs-task-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
EOF
}