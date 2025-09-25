output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.main["cluster"].kube_config[0].raw_config
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = digitalocean_kubernetes_cluster.main["cluster"].kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_endpoint" {
  value     = digitalocean_kubernetes_cluster.main["cluster"].kube_config[0].host
  sensitive = true
}

output "cluster_token" {
  value     = digitalocean_kubernetes_cluster.main["cluster"].kube_config[0].token
  sensitive = true
}




