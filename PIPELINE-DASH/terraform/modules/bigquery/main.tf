provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}
resource "google_bigquery_dataset" "gold" {
  dataset_id = "${var.prefix}_gold"
  project    = var.gcp_project
  location   = var.gcp_region
}
resource "google_bigquery_dataset" "silver" {
  dataset_id = "${var.prefix}_silver"
  project    = var.gcp_project
  location   = var.gcp_region
}
resource "google_bigquery_dataset" "bronze" {
  dataset_id                  = "${var.prefix}_bronze"
  project                     = var.gcp_project
  location                    = var.gcp_region
  default_table_expiration_ms = var.retention_days * 24 * 60 * 60 * 1000
}

resource "google_bigquery_dataset_iam_member" "gold_writer" {
  dataset_id = google_bigquery_dataset.gold.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${var.ingestor_service_account}"
}
resource "google_bigquery_dataset_iam_member" "silver_writer" {
  dataset_id = google_bigquery_dataset.silver.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${var.ingestor_service_account}"
}
resource "google_bigquery_dataset_iam_member" "bronze_writer" {
  dataset_id = google_bigquery_dataset.bronze.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${var.ingestor_service_account}"
}
resource "google_bigquery_table" "raw" {
  dataset_id = google_bigquery_dataset.bronze.dataset_id
  table_id   = "${var.prefix}_raw"

  schema = file("${path.module}/schemas/wdi_raw_schema.json")

  time_partitioning {
    type  = "DAY"
    field = "date"
  }

  clustering = ["country_code", "series_code"]
}