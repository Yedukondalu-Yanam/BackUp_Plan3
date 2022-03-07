resource "aws_kms_key" "aws_backup_key" {
  description             = "AWS Backup KMS key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
    tags = {
    name = var.backup_vault_name
  }
}

resource "aws_backup_vault" "backup-vault" {
  name        = var.backup_vault_name
  kms_key_arn = aws_kms_key.aws_backup_key.arn
  tags = {
    Role = "backup-vault"
  }
}

resource "aws_backup_plan" "backup-plan" {
  name = var.backup_plan_name
  dynamic "rule" {
    for_each = var.rules
    content {
      rule_name                = lookup(rule.value, "name", null)
      target_vault_name        = aws_backup_vault.backup-vault.name
      schedule                 = lookup(rule.value, "schedule", null)
      start_window             = lookup(rule.value, "start_window", null)
      completion_window        = lookup(rule.value, "completion_window", null)
      enable_continuous_backup = lookup(rule.value, "enable_continuous_backup", null)
      recovery_point_tags = {
        Frequency  = lookup(rule.value, "name", null)
        Created_By = "aws-backup"
      }
      lifecycle {
        delete_after = lookup(rule.value, "delete_after", null)
      }
    }
  }
}

resource "aws_backup_selection" "backup-selection" {

  iam_role_arn = var.AWS_Backup_Service_Role
  name         = var.backup_vault_name
  plan_id      = aws_backup_plan.backup-plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.key
    value = var.value
  }
}