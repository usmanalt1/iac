terraform {
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "bigquery" {
  source = "../../modules/bigquery"

  project_id = var.project_id
  env        = var.env
}

module "iam" {
  source = "../../modules/iam"

  project_id = var.project_id
  env        = var.env
}