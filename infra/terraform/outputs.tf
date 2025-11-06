output "ec2_public_ip" {
  value = aws_instance.devops_instance.public_ip
}

output "frontend_ecr_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_ecr_url" {
  value = aws_ecr_repository.backend.repository_url
}

