# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

source "null" "vyoco" {
    communicator = "none"
}

source "vmware-iso" "vyoco" {
  boot_command          = var.boot_command
  boot_wait          	  = var.boot_wait
  cpus               	  = var.cpus
  memory             	  = var.memory
  disk_size             = var.disk_size
  network_adapter_type  = var.network_adapter_type
  vmx_data              = var.vmx_data
  iso_checksum       	  = var.iso_checksum
  iso_urls            	= var.iso_urls
  http_directory        = var.data_directory
  output_directory      = "builds/${source.name}-${source.type}"
  communicator          = "ssh"
  ssh_username          = var.user_name
  ssh_password          = var.user_password
  ssh_port              = 22
  ssh_timeout           = "3600s"
  shutdown_command      = "echo '${var.user_password}' | sudo -S shutdown -P now"
  version               = var.vmware_version
}