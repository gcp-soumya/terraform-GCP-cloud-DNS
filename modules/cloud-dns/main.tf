# Resource: Google Cloud DNS Managed Zone
# Creates a public managed zone in Cloud DNS.
resource "google_dns_managed_zone" "this" {
  project     = var.project_id
  name        = var.zone_name
  dns_name    = "${var.domain_name}." # Trailing dot is crucial for FQDN
  description = "Managed zone for ${var.domain_name}"

  # Optional: For private zones, uncomment and configure
  # visibility = "private"
  # private_visibility_config {
  #   network_urls = [
  #     for network in var.private_zone_networks :
  #     "projects/${var.project_id}/global/networks/${network}"
  #   ]
  # }
}

# Resource: Google Cloud DNS A Records
# Creates multiple A records based on the 'a_records' variable.
resource "google_dns_record_set" "a_records" {
  for_each     = var.a_records
  name         = "${each.key}.${google_dns_managed_zone.this.dns_name}"
  type         = "A"
  ttl          = var.ttl_seconds
  managed_zone = google_dns_managed_zone.this.name
  project      = var.project_id
  rrdatas      = [each.value]
}

# Resource: Google Cloud DNS CNAME Records
# Creates multiple CNAME records based on the 'cname_records' variable.
resource "google_dns_record_set" "cname_records" {
  for_each     = var.cname_records
  name         = "${each.key}.${google_dns_managed_zone.this.dns_name}"
  type         = "CNAME"
  ttl          = var.ttl_seconds
  managed_zone = google_dns_managed_zone.this.name
  project      = var.project_id
  rrdatas      = ["${each.value}."] # Target must also be FQDN with a trailing dot
}

# Resource: Google Cloud DNS MX Records
# Creates MX records. Note: MX records usually apply to the domain root, not subdomains.
resource "google_dns_record_set" "mx_records" {
  count        = length(var.mx_records) > 0 ? 1 : 0 # Only create if MX records are provided
  name         = google_dns_managed_zone.this.dns_name
  type         = "MX"
  ttl          = var.ttl_seconds
  managed_zone = google_dns_managed_zone.this.name
  project      = var.project_id
  rrdatas      = [
    for mx in var.mx_records : "${mx.priority} ${mx.exchange}."
  ]
}

# Add other record types (TXT, SRV, etc.) similarly if needed.
