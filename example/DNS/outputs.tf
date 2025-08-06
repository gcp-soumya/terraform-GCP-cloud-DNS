output "primary_domain_nameservers" {
  description = "Name servers for your primary domain. Update your registrar with these."
  value       = module.my_domain_dns.nameservers
}

output "primary_domain_zone_name" {
  description = "The name of the created primary DNS zone."
  value       = module.my_domain_dns.managed_zone_name
}
