[
  {
    "name": "${app_name}-${env}-app",
    "image": "${app_image}",
    "cpu": 512,
    "memory": 1024,
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "environment": ${env_vars}
  }
]