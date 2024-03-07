# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

variable "vagrant_cloud_account" {
  type        = string
  default     = null
}

variable "vagrant_cloud_box_version" {
  type        = string
  default     = null
}

variable "vagrant_cloud_box_description" {
  type        = string
  default     = null
}

variable "vagrant_cloud_access_token" {
  type        = string
  default     = env("PKR_VAR_VAGRANT_CLOUD_TOKEN")
  sensitive   = true
}

variable "vagrant_keep_input_artifact" {
  type        = bool
  default     = true
}
