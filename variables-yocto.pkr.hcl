# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

variable "yocto_packages" {
  type        = map(string)
  default     = null
}

variable "yocto_poky_rev" {
  type        = map(string)
  default     = null
}

variable "yocto_identifier" {
  type        = string
  default     = env("PKR_VAR_YOCTO_IDENTIFIER")
  description = "Identifier used as a key for 'yocto_...' map variables"
}

variable "yocto_workspace_dir" {
  type        = string
  default     = null
}


