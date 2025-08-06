variable "project_id" {
  description = "The GCP project ID where the Cloud DNS zone will be created."
  type        = string
}

variable "domain_name" {
  description = "The base domain name for the managed zone (e.g., 'example.com')."
  type        = string
}

variable "zone_name" {
  description = "A unique name for the Cloud DNS managed zone (e.g., 'my-app-zone')."
  type        = string
}

variable "ttl_seconds" {
  description = "The Time To Live (TTL) for DNS records in seconds."
  type        = number
  default     = 300 # 5 minutes
}

variable "a_records" {
  description = "A map of A records. Key is the subdomain (e.g., 'www'), value is the IP address."
  type        = map(string)
  default     = {}
}

variable "cname_records" {
  description = "A map of CNAME records. Key is the subdomain (e.g., 'blog'), value is the target FQDN."
  type        = map(string)
  default     = {}
}

variable "mx_records" {
  description = "A list of MX record objects. Each object has 'priority' (number) and 'exchange' (string FQDN)."
  type = list(object({
    priority = number
    exchange = string
  }))
  default = []
}

# Optional: For private zones
variable "private_zone_networks" {
  description = "List of VPC network names if creating a private zone."
  type        = list(string)
  default     = []
}
