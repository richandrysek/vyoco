# vyoco

[andrysek](https://andrysek.de/)

Virtual machine with Yocto for developers, when you can't use a container.

## System requirements

vagrant                 2.4.1
packer                  1.10.1
vmware                  17.5.0 build-22583795
Vagrant VMware Utility  1.0.22

Then install the Vagrant plugin in the terminal

    vagrant plugin install vagrant-vmware-desktop
    vagrant plugin list

## Quick start - vmware

The build releases are available on <https://app.vagrantup.com/richandrysek/boxes/vyoco> .

1) Create a Vagrantfile

    vagrant init richandrysek/vyoco

   Add these lines to login and to update a ssh key:

    config.ssh.password = 'vagrant'
    config.ssh.insert_key = true

2) Start your virtual machine

    vagrant up --provider=vmware_desktop

3) Connect via ssh

    vagrant ssh

   Note: User "vagrant" and password "vagrant".

4) Change a directory to a prepared workspace

    cd ~/workspace
    ls

5) Clone a tested poky version

    source source/clone_poky.sh

6) Create your build directory

    source source/poky/oe-init-build-env

7) It is recommend to share some directories in your "build/conf/local.conf" to build
   yocto artifacts faster, please use these settings

    DL_DIR ?= "/home/vagrant/workspace/share/bitbake.downloads"
    SSTATE_DIR ?= "/home/vagrant/workspace/share/sstate-cache"

8) Enjoy your yocto development

## Documentation

* [Getting Started](https://github.com/richandrysek/vyoco/blob/main/doc/OVERVIEW.md)
* [Vagrant cloud box](https://app.vagrantup.com/richandrysek/boxes/vyoco)
