data "google_project" "current" {
  project_id = var.gcp_project
}

resource "google_storage_bucket" "raw" {
  name          = "${var.gcp_project}-wdi-raw"
  location      = var.gcp_region
  force_destroy = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket_iam_member" "raw_writer_ingestor" {
  bucket = google_storage_bucket.raw.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.ingestor_sa_email}"
}

resource "google_storage_bucket_iam_member" "raw_writer_composer" {
  bucket = google_storage_bucket.raw.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com"
}