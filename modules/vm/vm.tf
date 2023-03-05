terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.13"
    }
  }
}

resource "proxmox_vm_qemu" "test_server" {
  name = var.vm_name
  target_node = var.node
  clone = var.clone
  cipassword = var.password
  ciuser = var.user
  os_type = "cloud-init"
  cores = var.cores
  sockets = 1
  cpu = "host"
  memory = var.ram
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = var.disk-size
    type = "scsi"
    storage = "local-lvm"
  }
  
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.0.51/24,gw=192.168.0.1"
  
  # sshkeys set using variables. the variable contains the text of the key.
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}