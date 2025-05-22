output "wdi_ingestor_sa_email" {
  value       = google_service_account.wdi_ingestor.email
}

output "composer_worker_sa_email" {
  value       = google_service_account.composer_worker.email
}
