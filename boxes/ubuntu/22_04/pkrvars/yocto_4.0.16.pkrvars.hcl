# Copyright (c) andrysek.de
# SPDX-License-Identifier: MPL-2.0

yocto_tools     = <<-EOF
                    gawk wget git diffstat unzip texinfo gcc-multilib build-essential \
                    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
                    debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa \
                    libsdl1.2-dev python3-subunit mesa-common-dev zstd liblz4-tool \
                    openssl curl gnutls-bin file locales libacl1 make cmake \
                    python3-sphinx
                  EOF

yocto_poky_rev  = "kirkstone-4.0.16"
