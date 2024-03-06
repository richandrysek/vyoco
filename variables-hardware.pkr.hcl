# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

variable "cpus" {
  type        = number
  default     = null
}

variable "memory" {
  type        = number
  default     = null
}

variable "disk_size" {
  type        = number
  default     = null
}

variable "network_adapter_type" {
  type        = string
  default     = null
}

variable "vmx_data" {
  type        = map(string)
  default     = {
    "cpuid.coresPerSocket" = "2"
  }
}

variable "vmware_version" {
  type        = number
  default     = null
}
