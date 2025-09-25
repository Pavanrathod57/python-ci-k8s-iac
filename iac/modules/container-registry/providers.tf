terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.13"
}

provider "digitalocean" {
  token = var.digitalocean_token
}


