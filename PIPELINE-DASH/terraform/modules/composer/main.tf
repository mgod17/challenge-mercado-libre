resource "google_composer_environment" "airflow" {
  name   = "wdi-composer"  
  region = var.gcp_region
  project = var.gcp_project

  config {
    software_config {
      image_version = "composer-2.13.0-airflow-2.10.5"  
      env_variables = {
        BQ_PROJECT = var.gcp_project
        BQ_DATASET = "wdi_staging"
        BQ_TABLE   = "internet_raw"
      }
    }
  }

 
}


