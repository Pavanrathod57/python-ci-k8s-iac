output "container_registry_url" {
  value       = digitalocean_container_registry.main["registry"].endpoint
  description = "The URL of the DigitalOcean Container Registry"
}
