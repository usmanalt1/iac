terraform {
  backend "gcs" {
    bucket = "nba-ua-prod-tf-state"
    prefix = "prod"
  }
}