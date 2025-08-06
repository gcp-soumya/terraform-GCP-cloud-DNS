# Call the Cloud DNS module to create a managed zone and records
module "my_domain_dns" {
  source = "../../modules/cloud-dns" # Path to your module directory

  project_id  = var.gcp_project_id
  domain_name = var.my_domain_name
  zone_name   = var.my_zone_name # Must be unique within your GCP project

  # Example A records
  a_records = {
    "www"      = "203.0.113.10",
    "app"      = "203.0.113.11",
    "sub.test" = "203.0.113.12" # You can have nested subdomains
  }

  # Example CNAME records
  cname_records = {
    "blog" = "ghs.googlehosted.com",
    "cdn"  = "cdn.another-service.com"
  }

  # Example MX records for the root domain
  mx_records = [
    { priority = 10, exchange = "alt1.aspmx.l.google.com" },
    { priority = 20, exchange = "alt2.aspmx.l.google.com" }
  ]

  ttl_seconds = 300 # Override default TTL if needed
}

# If you need another domain, just call the module again:
# module "another_domain_dns" {
#   source      = "./modules/cloud-dns"
#   project_id  = var.gcp_project_id
#   domain_name = "anotherdomain.net"
#   zone_name   = "another-domain-net-zone"
#   a_records = {
#     "web" = "203.0.113.20"
#   }
# }
