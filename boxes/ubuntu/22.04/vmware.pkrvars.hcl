# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

# Hardware
cpus                    = 8
memory                  = 16384
disk_size               = 204800
network_adapter_type    = "e1000e"
vmx_data                = {
                          "cpuid.coresPerSocket"    = "2"
                          "ethernet0.pciSlotNumber" = "32"
                          "svga.autodetect"         = true
                          "usb_xhci.present"        = true
                          }
vmware_version          = 21

# Operating system
user_name               = "vagrant"
user_password           = "vagrant"
boot_wait               = "10s"
iso_urls                = ["iso/ubuntu-22.04.4-live-server-amd64.iso",
                           "https://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso"]
iso_checksum            = "45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2"
guest_os_type           = "ubuntu-64"
boot_command            = [
                          "c",
                          "linux /casper/vmlinuz --- ds='nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/'  autoinstall quiet --- ",
                          "<enter><wait>",
                          "initrd /casper/initrd<enter><wait>",
                          "boot<enter>",
                          ]
data_directory          = "./boxes/ubuntu/22.04/data"
