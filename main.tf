terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.13"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.api
  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = var.token_id
  pm_api_token_secret = var.token_secret
  pm_tls_insecure = true
}

module "test-vm" {
    source = "./modules/vm"
    vm_name = "k8s"
    node = "proxmox"
    clone = "ubuntu2204"
    cores = 2
    disk-size = "10G"
    ram = 2048
    ssh_key = var.sshkey
    user = "galexo"
    password = var.password
}