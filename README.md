# vyoco

[andrysek](https://andrysek.de/)

Virtual machine with Yocto for developers, when you can't use a container.

## System requirements

vagrant                 2.4.1
packer                  1.10.1
vmware                  17.5.0 build-22583795
Vagrant VMware Utility  1.0.22

Then install the Vagrant plugin in the terminal:

```shell
vagrant plugin install vagrant-vmware-desktop
vagrant plugin list
```

## Quick start - vmware

The build releases are available on <https://app.vagrantup.com/richandrysek/boxes/vyoco> .

1) Create a Vagrantfile:

    ```shell
    vagrant init richandrysek/vyoco
    ```

2) Add these lines to login and to update a ssh key:

    ```text
    config.ssh.password = 'vagrant'
    config.ssh.insert_key = true
    ```

3) Start your virtual machine:

    ```shell
    vagrant up --provider=vmware_desktop
    ```

4) Connect via ssh:

    ```shell
    vagrant ssh
    ```

   Note: User "vagrant" and password "vagrant".

5) Change a directory to a prepared workspace:

    ```shell
    cd ~/workspace
    ls
    ```

6) Clone a tested poky version:

    ```shell
    source source/clone_poky.sh
    ```

    Note: It depends on your internet connection how fast it will be done.

7) Create your build directory:

    ```shell
    source source/poky/oe-init-build-env
    ```

8) It is recommend to share some directories in your "build/conf/local.conf"
   to build yocto artifacts faster, please use these settings:

    ```text
    DL_DIR ?= "/home/vagrant/workspace/share/bitbake.downloads"
    SSTATE_DIR ?= "/home/vagrant/workspace/share/sstate-cache"
    ```

9) Enjoy your yocto development

## Documentation

* [Getting Started](https://github.com/richandrysek/vyoco/blob/main/doc/OVERVIEW.md)
* [Vagrant cloud box](https://app.vagrantup.com/richandrysek/boxes/vyoco)
