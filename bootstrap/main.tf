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
  region = var.region
}

locals {
  environments = ["dev", "prod"]

  project_ids = {
    dev  = "nba-ua-dev"
    prod = "nba-ua-prod"
  }

  apis = [
    "bigquery.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
  ]

  project_apis = {
    for pair in setproduct(local.environments, local.apis) :
    "${pair[0]}/${pair[1]}" => {
      environment = pair[0]
      api         = pair[1]
    }
  }
}

resource "google_project" "projects" {
  for_each = toset(local.environments)

  name            = "nba-app-${each.value}"
  project_id      = local.project_ids[each.value]
  billing_account = var.billing_account_id
}

resource "google_project_service" "apis" {
  for_each = local.project_apis

  project            = google_project.projects[each.value.environment].project_id
  service            = each.value.api
  disable_on_destroy = false

  depends_on = [google_project.projects]
}

resource "google_storage_bucket" "tf_state" {
  for_each = toset(local.environments)

  name          = "${local.project_ids[each.value]}-tf-state"
  location      = "EU"
  project       = google_project.projects[each.value].project_id
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [google_project_service.apis]
}