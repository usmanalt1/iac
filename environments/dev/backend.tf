terraform {
  backend "gcs" {
    bucket = "nba-ua-dev-tf-state"
    prefix = "dev"
  }
}