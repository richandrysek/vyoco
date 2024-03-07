# vyoco

[andrysek](https://andrysek.de/)

Virtual machine with Yocto for developers if you cannot use a container.

## System requirements

|SW Component           |Version                |
|-----------------------|-----------------------|
|vagrant                | 2.4.1                 |
|packer                 | 1.10.1                |
|vmware                 | 17.5.0 build-22583795 |
|Vagrant VMware Utility | 1.0.22                |

Then install the Vagrant plugin in the terminal:

```shell
vagrant plugin install vagrant-vmware-desktop
vagrant plugin list
```

## Quick start - vmware

The build releases are available on <https://app.vagrantup.com/richandrysek/boxes/vyoco> .
It depends on your internet connection how fast it will be done.

1) Go to subdirectory "test/cloud"

    ```shell
    cd test/cloud
    ```

2) Start a virtual machine and check its status:

    ```shell
    vagrant up --provider=vmware_desktop
    vagrant status
    ```

    The box is downloaded and the hash value sha512 is automatically checked,
    the virtual machine is then created and started.

3) Clone a specific and only specific branch of yocto:

    ```shell
    vagrant ssh -c "cd ~/workspace && source source/clone_poky.sh"
    ```

4) Connect via ssh:

    ```shell
    vagrant ssh
    ```

   Note: User "vagrant" and password "vagrant".

5) Create your build directory:

    ```shell
    cd ~/workspace
    source source/poky/oe-init-build-env
    ```

6) It is recommend to share some directories in your "build/conf/local.conf"
   to build yocto artifacts faster, please use these settings:

    ```text
    DL_DIR ?= "/home/vagrant/workspace/share/bitbake.downloads"
    SSTATE_DIR ?= "/home/vagrant/workspace/share/sstate-cache"
    ```

7) Enjoy your yocto development

## Documentation

* [Getting Started](https://github.com/richandrysek/vyoco/blob/main/doc/OVERVIEW.md)
* [Changelog](https://github.com/richandrysek/vyoco/blob/main/CHANGELOG)
* [Vagrant cloud box](https://app.vagrantup.com/richandrysek/boxes/vyoco)
* [Support](https://github.com/richandrysek/vyoco/blob/main/SUPPORT)
* [Security](https://github.com/richandrysek/vyoco/blob/main/SECURITY)
* [Discuss about voyco!](https://github.com/richandrysek/vyoco/discussions/1)
