variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "kubernetes_cluster_config" {
  description = "Configuration for the Kubernetes cluster"
  type = object({
    name                 = optional(string, null)
    region               = optional(string, null)
    cluster_version      = optional(string, null)
    ha                   = optional(bool, false)
    registry_integration = optional(string, null)
    tags                 = optional(list(string), [])
    node_pool_name       = optional(string, null)
    node_pool_size       = optional(string, null)
    node_pool_node_count = optional(number, 1)
    node_pool_auto_scale = optional(bool, false)
  })
  default = {}
}

variable "critical_node_pool" {
  description = "List of maps defining critical node pools"
  type = list(object({
    name       = optional(string, null)
    size       = optional(string, null)
    node_count = optional(number, 0)
    auto_scale = optional(bool, false)
    min_nodes  = optional(number, 0)
    max_nodes  = optional(number, 0)
    tags       = optional(list(string), [])
    labels     = optional(map(string), {})
    taint = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
  default = []
}

variable "app_node_pools" {
  description = "List of maps defining application node pools"
  type = list(object({
    name       = optional(string, null)
    size       = optional(string, null)
    node_count = optional(number, 0)
    auto_scale = optional(bool, false)
    min_nodes  = optional(number, 0)
    max_nodes  = optional(number, 0)
    tags       = optional(list(string), [])
    labels     = optional(map(string), {})
    taint = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
  default = []
}

