resource "digitalocean_container_registry" "main" {
  for_each = var.enabled ? { "registry" = var.name } : {}
  name                   = each.value
  region                 = var.region
  subscription_tier_slug = var.subscription_tier_slug
}
