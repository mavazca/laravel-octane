// Cria um certificado ACM para o domínio principal
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    var.subdomain_wildcard,
  ]

  tags = var.project_tags

  lifecycle {
    create_before_destroy = true
  }
}

// Valida o certificado ACM usando registros DNS
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
