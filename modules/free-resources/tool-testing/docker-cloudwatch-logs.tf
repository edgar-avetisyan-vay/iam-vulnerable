# Demonstrates tag-based permissions for CloudWatch logging

resource "aws_cloudwatch_log_group" "docker" {
  name              = "docker-log-group"
  retention_in_days = 7
  tags = {
    DockerLogs = "allowed"
  }
}

resource "aws_iam_group" "docker_logs_group" {
  name = "docker-logs-group"
}

resource "aws_iam_user" "docker_logger_user" {
  name = "docker-logger-user"
  tags = {
    DockerLogs = "allowed"
  }
}

resource "aws_iam_access_key" "docker_logger_user" {
  user = aws_iam_user.docker_logger_user.name
}

resource "aws_iam_group_membership" "docker_logs_group_membership" {
  name  = "docker-logs-group-membership"
  users = [aws_iam_user.docker_logger_user.name]
  group = aws_iam_group.docker_logs_group.name
}

resource "aws_iam_policy" "docker_logs_policy" {
  name        = "docker-logs-policy"
  description = "Allow putting logs to the Docker log group only when tags match"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = aws_cloudwatch_log_group.docker.arn
        Condition = {
          StringEquals = {
            "aws:ResourceTag/DockerLogs"  = "allowed"
            "aws:PrincipalTag/DockerLogs" = "allowed"
          }
        }
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "docker_logs_group_attach" {
  group      = aws_iam_group.docker_logs_group.name
  policy_arn = aws_iam_policy.docker_logs_policy.arn
}
