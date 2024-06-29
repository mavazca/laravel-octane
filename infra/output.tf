output "ecr_repository_url" {
  value = aws_ecr_repository.ECR.repository_url
}

output "lb_dns_name" {
  value = aws_lb.LB.dns_name
}