# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vmware = {
      version = ">= 1.0.7"
      source  = "github.com/hashicorp/vmware"
    }
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

# The checksum is valid after "build_vyoco" step
locals {
  box_file            = "builds/vyoco_vmware-iso_${var.vagrant_cloud_box_version}.box"
  box_checksum_type   = "sha512"
  box_file_checksum   = "${local.box_file}.${local.box_checksum_type}"
  box_checksum_line   = fileexists(local.box_file_checksum) ? file(local.box_file_checksum) : "invalid"
  box_checksum_value  = substr(local.box_checksum_line, 0, 128)
  box_checksum        = "${local.box_checksum_type}:${local.box_checksum_value}"
}

build {
  name    = "build_vyoco"
  sources = ["source.vmware-iso.vyoco"]

  provisioner "shell" {
    name     = "Install yocto toolchain & store version"
    inline   = [
      "DEBIAN_FRONTEND=noninteractive sudo apt-get update",
      "DEBIAN_FRONTEND=noninteractive sudo apt install -y ${var.yocto_tools}",
      "sudo sh -c 'echo \"Version: ${var.vagrant_cloud_box_version}\" > /etc/vyoco'"
    ]
  }

  provisioner "shell" {
    name     = "Install a default vagrant public key"
    inline   = [
      "mkdir -pm 700 /home/${var.user_name}/.ssh",
      "wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/${var.user_name}/.ssh/authorized_keys",
      "chmod 600 /home/${var.user_name}/.ssh/authorized_keys",
      "chown -R ${var.user_name}:${var.user_name} /home/${var.user_name}/.ssh"
    ]
  }

  provisioner "shell" {
    name     = "Prepare a yocto workspace"
    inline   = [
      "mkdir -p ${var.yocto_workspace_dir}/share/bitbake.downloads",
      "mkdir -p ${var.yocto_workspace_dir}/share/sstate-cache",
      "mkdir -p ${var.yocto_workspace_dir}/source",
      "echo \"git clone -b ${var.yocto_poky_rev} git://git.yoctoproject.org/poky.git\" > ${var.yocto_workspace_dir}/source/clone_poky.sh",
    ]
  }

  post-processors {

    post-processor "vagrant" {
      keep_input_artifact = var.vagrant_keep_input_artifact
      output              = "builds/${source.name}_${source.type}_${var.vagrant_cloud_box_version}.box"
      provider_override   = "vmware"
    }

    post-processor "checksum" {
      checksum_types      = ["sha512"]
      keep_input_artifact = true
      output              = "builds/${source.name}_${source.type}_${var.vagrant_cloud_box_version}.box.{{.ChecksumType}}"
    }
  }

}

build {
  name    = "upload_vyoco"
  sources = ["source.null.vyoco"]

  post-processors {
    post-processor "artifice" { # tell packer this is now the new artifact
      files               = ["${local.box_file}"]
      keep_input_artifact = true
    }

    post-processor "vagrant-cloud" {
      access_token        = var.vagrant_cloud_access_token
      box_tag             = "${var.vagrant_cloud_account}/${source.name}"
      version             = var.vagrant_cloud_box_version
      architecture        = "amd64"
      version_description = var.vagrant_cloud_box_description
      box_checksum        = local.box_checksum
    }
  }
}