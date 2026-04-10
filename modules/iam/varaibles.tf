variable "project_id" {
  type = string
}

variable "env" {
  type = string
}

variable "service_account_name" {
  type    = string
  default = "dbt-sa"
}