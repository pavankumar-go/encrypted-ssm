data "aws_kms_secrets" "secret" {
  secret {
    name    = "secret"
    payload = file(var.encrypted_file_path)
  }
}

resource "aws_ssm_parameter" "parameter" {
  name        = var.name
  description = var.description
  type        = "SecureString"
  value       = data.aws_kms_secrets.secret.plaintext["secret"]
  tags        = var.tags
  depends_on = [data.aws_kms_secrets.secret]
}
