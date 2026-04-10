output "dbt_service_account_email" {
  value = google_service_account.dbt.email
}