locals {
  encrypted_secrets = yamldecode(file(var.encrypted_secrets_file_path))  
}

data "aws_kms_secrets" "secret" {
  dynamic secret {
    for_each = var.parameters
    content {
      name    = secret.value.key // 1. holds the yaml key ex: PASS1
      payload = local.encrypted_secrets[secret.value.name] // 2. holds the yaml value for the key PASS1 ex: AQ....
    }
  }
}

resource "aws_ssm_parameter" "parameter" {
  for_each    = { for parameter in var.parameters : parameter.name => parameter }
  name        = each.value.key 
  value       = data.aws_kms_secrets.secret.plaintext[each.value.key] // decrypted value of (2)
  description = var.description
  type        = "SecureString"
  tags        = var.tags
}
