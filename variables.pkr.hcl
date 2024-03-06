# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

variable "boot_command" {
  type        = list(string)
  default     = [] 
}

variable "boot_wait" {
  type        = string
  default     = null
}

variable "iso_checksum" {
  type        = string
  default     = null
}

variable "iso_urls" {
  type        = list(string)
  default     = null
}

variable "data_directory" {
  type        = string
  default     = "null"
}

variable "user_name" {
  type        = string
  default     = null
}

variable "user_password" {
  type        = string
  default     = null
  sensitive   = true
}

variable "guest_os_type" {
  type        = string
  default     = null
}
