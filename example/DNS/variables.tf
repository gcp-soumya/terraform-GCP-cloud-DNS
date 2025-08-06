variable "gcp_project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region (for provider configuration, Cloud DNS is global)."
  type        = string
  default     = "us-central1"
}

variable "my_domain_name" {
  description = "The primary domain name for the first DNS zone."
  type        = string
}

variable "my_zone_name" {
  description = "A unique name for the first Cloud DNS managed zone."
  type        = string
}
