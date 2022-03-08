provider "aws" {
  region = "us-east-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}


module "mcds_ams_daily_prod" {
  source                   = "./backup_module"
  key                      = "mcds_ams_daily_prod"
  value                    = "True"
  backup_vault_name        = "mcds_ams_daily_prod"
  backup_plan_name         = "ams_daily_prod_backup_plan"
  AWS_Backup_Service_Role  = aws_iam_role.aws-backup-service-role.arn

  rules = [{
  name                     = "daily_snapshot"
  schedule                 = var.daily_schedule
  start_window             = var.start_window
  completion_window        = var.completion_window
  delete_after             = var.delete_after
  enable_continuous_backup = true
  }]
}

module "mcds_ams_weekly_non_prod" {
  source                   = "./backup_module"
  key                      = "mcds_ams_weekly_non_prod"
  value                    = "True"
  backup_vault_name        = "mcds_ams_weekly_non_prod"
  backup_plan_name         = "ams_weekly_non_prod_backup_plan"
  AWS_Backup_Service_Role  = aws_iam_role.aws-backup-service-role.arn
  
  rules = [{
  name                     = "weekly_snapshot"
  schedule                 = var.weekly_schedule
  start_window             = var.start_window
  completion_window        = var.completion_window
  delete_after             = 14
  enable_continuous_backup = true
  }]
}

module "mcds_ams_monthly_prod" {
  source                   = "./backup_module"
  key                      = "mcds_ams_monthly_prod"
  value                    = "True"
  backup_vault_name        = "mcds_ams_monthly_prod"
  backup_plan_name         = "ams_monthly_backup_plan"
  AWS_Backup_Service_Role  = aws_iam_role.aws-backup-service-role.arn
  
  rules = [{
  name                     = "monthly_snapshot"
  schedule                 = var.monthly_schedule
  start_window             = var.start_window
  completion_window        = var.completion_window
  delete_after             = var.delete_after
  enable_continuous_backup = true
  }]
}

module "mcds_ams_yearly_prod" {
  source                   = "./backup_module"
  key                      = "mcds_ams_yearly_prod"
  value                    = "True"
  backup_vault_name        = "mcds_ams_yearly_prod"
  backup_plan_name         = "ams_yearly_backup_plan"
  AWS_Backup_Service_Role  = aws_iam_role.aws-backup-service-role.arn
  
  rules = [{
  name                     = "yearly_snapshot"
  schedule                 = var.yearly_schedule
  start_window             = var.start_window
  completion_window        = var.completion_window
  delete_after             = 14
  enable_continuous_backup = true
  }]
}