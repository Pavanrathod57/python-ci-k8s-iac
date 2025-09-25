variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "enabled" {
  type = bool
}

variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "subscription_tier_slug" {
  type = string
}
