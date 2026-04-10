variable "billing_account_id" {
  type        = string
  description = "GCP billing account to attach to the project"
}

variable "project_id" {
  type        = string
  description = "GCP project ID — must be globally unique"
}

variable "region" {
  type    = string
  default = "europe-west2"
}