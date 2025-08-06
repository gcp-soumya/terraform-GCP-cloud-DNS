output "managed_zone_name" {
  description = "The name of the created DNS managed zone."
  value       = google_dns_managed_zone.this.name
}

output "dns_name" {
  description = "The DNS name of the managed zone (e.g., 'example.com.')."
  value       = google_dns_managed_zone.this.dns_name
}

output "nameservers" {
  description = "The authoritative name servers for your managed zone. You must update your domain registrar with these."
  value       = google_dns_managed_zone.this.name_servers
}
