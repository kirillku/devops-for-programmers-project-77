terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "~> 2.0"
    }
  }
}

provider "ansiblevault" {
  vault_path  = "../.vault_pass.txt"
  root_folder = "."
}

data "ansiblevault_path" "do_token" {
  path = "./vault.yml"
  key  = "DO_TOKEN"
}

provider "digitalocean" {
  token = data.ansiblevault_path.do_token.value
}

data "digitalocean_ssh_key" "ssh1" {
  name = "kubry@KIRILL-LAPTOP"
}

variable "website" {
  default = "kubryakov.online"
}