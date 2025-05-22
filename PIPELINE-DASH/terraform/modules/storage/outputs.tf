output "raw_bucket_name" {
  description = "Nombre del bucket de datos crudos"
  value       = google_storage_bucket.raw.name
}