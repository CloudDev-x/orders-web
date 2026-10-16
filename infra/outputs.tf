output "ecr_repository_url" {
  description = "Full image URL prefix for docker push"
  value       = aws_ecr_repository.app.repository_url
}

output "instance_public_ip" {
  description = "Public IP of the web instance"
  value       = aws_instance.web.public_ip
}
