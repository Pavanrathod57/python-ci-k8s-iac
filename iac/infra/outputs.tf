output "kubeconfig" {
  value = {
    flasktest     = module.k8s_cluster.kubeconfig
  }
  sensitive = true
}

output "cluster_endpoint" {
  value = {
    flasktest     = module.k8s_cluster.kubeconfig
  }
  sensitive = true
}

output "container_registry_url" {
  value = {
    container_registry = module.container_registry.container_registry_url
  }
}
