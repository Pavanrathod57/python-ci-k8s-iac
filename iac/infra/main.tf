locals {
  name                   = "kubernetes"
  region                 = "blr1"
  cluster_version        = "1.33.1-do.4"
  subscription_tier_slug = "starter"
}

module "k8s_cluster" {
  source = "../modules/kubernetes-cluster"
  kubernetes_cluster_config = {
    enabled              = true
    name                 = "${local.name}-cluster-flask-app"
    region               = local.region
    cluster_version      = local.cluster_version
    ha                   = false
    tags                 = ["flask", "k8s"]
    node_pool_name       = "default"
    node_pool_size       = "s-1vcpu-2gb"
    node_pool_node_count = 1
    node_pool_auto_scale = false
  }

  # critical_node_pool = [
  #   {
  #     name       = "critical"
  #     size       = "s-2vcpu-4gb"
  #     node_count = 1
  #     auto_scale = false
  #     min_nodes  = 1
  #     max_nodes  = 1
  #     tags       = ["critical"]
  #     labels     = { role = "critical" }
  #     taint      = []
  #   },
  #   {
  #     name       = "critical-01"
  #     size       = "s-2vcpu-4gb"
  #     node_count = 1
  #     auto_scale = false
  #     min_nodes  = 1
  #     max_nodes  = 1
  #     tags       = ["critical"]
  #     labels     = { role = "critical" }
  #     taint      = []
  #   }
  # ]

  # app_node_pools = [
  #   {
  #     name       = "app"
  #     size       = "s-1vcpu-2gb"
  #     node_count = 1
  #     auto_scale = true
  #     min_nodes  = 1
  #     max_nodes  = 1
  #     tags       = ["app"]
  #     labels     = { role = "app" }
  #     taint      = []
  #   }
  # ]
}

module "container_registry" {
  source                 = "../modules/container-registry"
  enabled                = true
  name                   = "${local.name}-image-registry-flask-app"
  region                 = local.region
  subscription_tier_slug = local.subscription_tier_slug
}
