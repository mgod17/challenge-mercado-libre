variable "gcp_project" {
  type        = string
}

variable "gcp_region" {
  type        = string
}

variable "ingestor_service_account" {
  type        = string
}

variable "prefix" {
  type        = string
  default     = "wdi_internet"
}

variable "retention_days" {
  type        = number
  default     = 30
}