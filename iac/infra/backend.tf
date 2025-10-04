terraform {
  required_version = ">= 1.13"
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "envs/terraform.tfstate"
    endpoints = {
      s3 = "https://blr1.digitaloceanspaces.com"
    }
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    use_path_style              = true
    region                      = "us-east-1"
  }
}
