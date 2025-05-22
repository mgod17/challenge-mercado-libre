variable "gcp_project" {
  description = "abstract-gizmo-441020-v4"
  type        = string
}

variable "gcp_region" {
  description = "Región donde se creará el bucket"
  type        = string
  default     = "us-central1"
}

variable "ingestor_sa_email" {
  description = "Email de la Service Account que usará el pipeline para escribir en el bucket"
  type        = string
}