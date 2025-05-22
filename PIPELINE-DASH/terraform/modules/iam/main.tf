resource "google_service_account" "wdi_ingestor" {
  account_id   = "wdi-ingestor"
  display_name = "WDI Ingestor SA"
}


resource "google_project_iam_member" "bq_data_editor" {
  project = var.gcp_project
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.wdi_ingestor.email}"
}
resource "google_service_account" "composer_worker" {
  account_id   = "composer-worker"
  display_name = "Composer Worker SA"
}

resource "google_project_iam_member" "bq_job_user" {
  project = var.gcp_project
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.wdi_ingestor.email}"
}