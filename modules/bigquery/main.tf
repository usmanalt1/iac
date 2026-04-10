resource "google_bigquery_dataset" "datasets" {
  for_each = toset(var.datasets)

  dataset_id = "${each.value}_${var.env}"
  project    = var.project_id
  location   = var.location

  labels = {
    env = var.env
  }
}