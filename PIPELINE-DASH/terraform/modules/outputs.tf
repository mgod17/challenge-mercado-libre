output "service_account_email" {
  description = "Email-SA"
  value       = module.iam.wdi_ingestor_sa_email
}

output "bucket_raw" {
  description = "Nombre del bucket"
  value       = module.storage.raw_bucket_name
}

# output "bq_dataset_staging" {
#   description = "Dataset de staging en BigQuery"
#   value       = module.bigquery.staging_dataset_id
# }

# output "cloud_function_url" {
#   description = "URL de la Cloud Function"
#   value       = module.function.function_url
# }
