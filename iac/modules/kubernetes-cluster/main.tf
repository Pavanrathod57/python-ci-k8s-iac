resource "digitalocean_kubernetes_cluster" "main" {
  for_each             = length(var.kubernetes_cluster_config) > 0 ? { "cluster" = var.kubernetes_cluster_config.name } : {}
  name                 = each.value
  region               = var.kubernetes_cluster_config.region
  version              = var.kubernetes_cluster_config.cluster_version
  ha                   = var.kubernetes_cluster_config.ha
  registry_integration = var.kubernetes_cluster_config.registry_integration
  tags                 = var.kubernetes_cluster_config.tags
  node_pool {
    name       = var.kubernetes_cluster_config.node_pool_name
    size       = var.kubernetes_cluster_config.node_pool_size
    node_count = var.kubernetes_cluster_config.node_pool_node_count
    auto_scale = var.kubernetes_cluster_config.node_pool_auto_scale
  }
}

resource "digitalocean_kubernetes_node_pool" "critical" {
  for_each   = length(var.critical_node_pool) > 0 ? { for k, v in var.critical_node_pool : k => v } : {}
  cluster_id = digitalocean_kubernetes_cluster.main["cluster"].id
  name       = each.value.name
  size       = each.value.size
  node_count = each.value.auto_scale ? null : each.value.node_count
  auto_scale = each.value.auto_scale
  min_nodes  = each.value.min_nodes
  max_nodes  = each.value.max_nodes
  tags       = each.value.tags
  labels     = each.value.labels
  dynamic "taint" {
    for_each = lookup(each.value, "taint", [])
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "app" {
  for_each   = length(var.app_node_pools) > 0 ? { for k, v in var.app_node_pools : k => v } : {}
  cluster_id = digitalocean_kubernetes_cluster.main["cluster"].id
  name       = each.value.name
  size       = each.value.size
  node_count = each.value.auto_scale ? null : each.value.node_count
  auto_scale = each.value.auto_scale
  min_nodes  = each.value.min_nodes
  max_nodes  = each.value.max_nodes
  tags       = each.value.tags
  labels     = each.value.labels
  dynamic "taint" {
    for_each = lookup(each.value, "taint", [])
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }
}
