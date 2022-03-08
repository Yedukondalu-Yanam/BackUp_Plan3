variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "daily_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a daily backup job"
  type        = string
  default     = "cron(00 5 ? * MON-SUN *)"
}

variable "weekly_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a weekly backup job"
  type        = string
  default     = "cron(0 5 ? * SAT *)"
}

variable "monthly_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a monthly backup job"
  type        = string
  default     = "cron(0 5 1 * ? *)"
  
}

variable "yearly_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a yearly backup job"
  type        = string
  default     = "cron(0 5 ? JAN 1 *)"
  
}

variable "start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = number
  default     = 60
}

variable "completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error"
  type        = number
  default     = 120
}

variable "delete_after" {
  type    = number
  default = 7
}