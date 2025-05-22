output "composer_env_name" {
  description = "Nombre del entorno de Cloud Composer"
  value       = google_composer_environment.airflow.name
}

output "composer_dags_prefix" {
  description = "Prefijo en GCS donde Composer busca los DAGs"
  value       = google_composer_environment.airflow.config[0].dag_gcs_prefix
}
