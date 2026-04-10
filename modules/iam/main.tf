resource "google_service_account" "dbt" {
  account_id   = "${var.service_account_name}-${var.env}"
  display_name = "dbt service account (${var.env})"
  project      = var.project_id
}

resource "google_project_iam_member" "dbt_bigquery_user" {
  project = var.project_id
  role    = "roles/bigquery.user"
  member  = "serviceAccount:${google_service_account.dbt.email}"
}

resource "google_project_iam_member" "dbt_bigquery_data_editor" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.dbt.email}"
}