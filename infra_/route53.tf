// infra/route53.tf

// Cria uma zona Route 53 para o domínio principal
resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = var.project_tags
}

// Cria um registro DNS para validação do certificado
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60

  lifecycle {
    ignore_changes = [records]
  }
}
