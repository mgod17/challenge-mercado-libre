output "bronze_dataset_id" {
  value       = google_bigquery_dataset.bronze.dataset_id
  description = "ID del dataset Bronze (raw)"
}

output "raw_table_id" {
  value       = google_bigquery_table.raw.table_id
  description = "ID de la tabla raw en BigQuery"
}