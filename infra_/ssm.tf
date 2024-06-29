// Cria parâmetros no AWS Systems Manager Parameter Store.
// Usa o tipo "SecureString" para parâmetros sensíveis como chaves e senhas,
// e "String" para os demais parâmetros. O nome do parâmetro inclui o ambiente
// e a chave para facilitar a organização e o acesso.
resource "aws_ssm_parameter" "env_parameters" {
  for_each = var.ssm_parameters

  name  = "/${var.environment}/${each.key}"
  type  = contains(var.secure_parameters, each.key) ? "SecureString" : "String"
  value = each.value

  tags = var.project_tags
}
