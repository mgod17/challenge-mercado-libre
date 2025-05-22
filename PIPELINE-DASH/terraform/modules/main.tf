terraform {
  required_version = ">= 1.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  
  }

  backend "gcs" {
    bucket = "mercado-libre-wdi-dash" 
    prefix = "internet-dashboard"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

module "iam" {
  source              = "./modules/iam"
  gcp_project         = var.gcp_project
}

module "storage" {
  source      = "./modules/storage"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  ingestor_sa_email = module.iam.wdi_ingestor_sa_email
}

module "bigquery" {
  source                   = "./modules/bigquery"
  gcp_project              = var.gcp_project
  gcp_region               = var.gcp_region
  ingestor_service_account = module.iam.wdi_ingestor_sa_email
  prefix                   = "wdi_internet"
  retention_days           = 30
}

module "composer" {
  source        = "./modules/composer"
  gcp_project   = var.gcp_project
  gcp_region    = var.gcp_region
}

