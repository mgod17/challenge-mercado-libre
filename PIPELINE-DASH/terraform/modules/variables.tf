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
# variable "looker_url" {
#   description = "URL de tu instancia Looker"
#   type        = string
# }

# variable "looker_client_id" {
#   description = "Client ID API Looker"
#   type        = string
# }

# variable "looker_client_secret" {
#   description = "Client Secret API Looker"
#   type        = string
# }
