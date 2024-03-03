# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

variable "boot_command" {
  type    = list(string)
  default = [] 
}

variable "cpus" {
  type    = number
  default = 8
}

variable "memory" {
  type    = number
  default = 16384
}

variable "disk_size" {
  type    = number
  default = 204800
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "iso_checksum" {
  type    = string
  default = null
}

variable "iso_urls" {
  type    = list(string)
  default = null
}

variable "data_directory" {
  type    = string
  default = "null"
}

variable "user_name" {
  type    = string
  default = "vagrant"
}

variable "user_password" {
  type    = string
  default = "vagrant"
}

variable "vm_guest_os_language" {
  type    = string
  default = "en"
}

variable "vm_guest_os_keyboard" {
  type    = string
  default = "us"
}

variable "vm_guest_os_timezone" {
  type    = string
  default = "UTC"
}

variable "guest_os_type" {
  type    = string
  default = null
}

variable "network_adapter_type" {
  type    = string
  default = null
}

variable "vmx_data" {
  type    = map(string)
  default = {
    "cpuid.coresPerSocket" = "2"
  }
}

variable "vmware_version" {
  type    = number
  default = null
}

variable "yocto_tools" {
  type    = string
  default = null
}

variable "yocto_poky_rev" {
  type    = string
  default = null
}

variable "yocto_workspace_dir" {
  type    = string
  default = "/home/vagrant/workspace"
}

variable "vagrant_keep_input_artifact" {
  type    = bool
  default = true
}

variable "vagrant_cloud_account" {
  type    = string
  default = null
}

variable "vagrant_cloud_box_version" {
  type    = string
  default = null
}

variable "vagrant_cloud_box_description" {
  type    = string
  default = null
}

variable "vagrant_cloud_access_token" {
  type    = string
  default = env("PKR_VAR_VAGRANT_CLOUD_TOKEN")
}
