variable "gcp_project" {
  type        = string
  default = "abstract-gizmo-441020-v4"
}

variable "gcp_region" {
  type        = string
  default     = "us-central1"
}
variable "composer_env_name" {
  description = "Nombre del entorno de Cloud Composer"
  type        = string
  default     = "wdi-composer"
}
