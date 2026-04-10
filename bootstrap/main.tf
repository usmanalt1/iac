terraform {
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  # intentionally no backend — bootstrap state lives locally
}

provider "google" {
  region = var.region
}

resource "google_project" "nba" {
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account_id
}

resource "google_project_service" "apis" {
  for_each = toset([
    "bigquery.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
  ])

  project            = google_project.nba.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_storage_bucket" "tf_state" {
  name          = "${var.project_id}-tf-state"
  location      = "EU"
  project       = google_project.nba.project_id
  force_destroy = false

  versioning {
    enabled = true
  }

  # prevent accidental deletion of state
  lifecycle {
    prevent_destroy = true
  }

  depends_on = [google_project_service.apis]
}