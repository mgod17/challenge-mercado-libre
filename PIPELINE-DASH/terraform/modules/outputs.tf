output "service_account_email" {
  description = "Email-SA"
  value       = module.iam.wdi_ingestor_sa_email
}

output "bucket_raw" {
  description = "Nombre del bucket"
  value       = module.storage.raw_bucket_name
}

