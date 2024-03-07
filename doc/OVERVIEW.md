# Getting started

## Configuration

### Virtual hardware

The current setting is for i9-13th generation, please adjust it to the values
of your host system. Adjust following variables in the file "variables.pkr.hcl":

* cpus
* memory
* disk_size

### Change password

Default password is "vagrant", to change it proceed this command:

```shell
python3 -c 'import crypt; print(crypt.crypt("vagrant", crypt.mksalt(crypt.METHOD_SHA512)))'
```

and exchange the result with a current content in a file
"boxes/ubuntu/22.4/data/user-data", part "identity->password"

### Build optimization(s)

To do not download each time the Ubuntu iso image you can click on the link
below and store an image into a subdirectory "iso" :

* <https://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso>

## Build

Proceed following commands to build a virtual machine and a vagrant box:

```shell
packer init .
packer validate -var-file="boxes/ubuntu/22.04/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22.04/yocto.pkrvars.hcl" -var="yocto_identifier=kirkstone-4.0.16" .
packer build -on-error=ask -only='build_vyoco.*' -var-file="boxes/ubuntu/22.04/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22.04/yocto.pkrvars.hcl" -var="yocto_identifier=kirkstone-4.0.16" .
```

After successful build will be created two files which can be uploaded
to app.vagrantup.com:

* vyoco_vmware-iso_X.X.X.box - vagrant box
* vyoco_vmware-iso_X.X.X.box.sha512 - file with a checksum for the vagrant vmware box

To upload the box to a vagrant cloud box "richandrysek/vyoco" proceed this command:

```shell
packer build -on-error=ask -only='upload_vyoco.*' -var-file="boxes/ubuntu/22.04/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22.04/yocto.pkrvars.hcl" -var="yocto_identifier=kirkstone-4.0.16" .
```

## Recreate a Vagrantfile in test/cloud

1) Go to subdirectory "test/cloud":

    ```shell
    cd test/cloud
    ```

2) Update the box to the last release version:

    ```shell
    vagrant box update --box richandrysek/vyoco
    vagrant box list
    ```

3) Force to recreate a Vagrantfile:

    ```shell
    vagrant init -f richandrysek/vyoco
    ```

4) Add the following lines below the line "config.vm.box = "vyoco"" to log in and update an ssh key:

    ```text
    config.ssh.password = 'vagrant'
    config.ssh.insert_key = true
    ```

## Debugging a box before uploading

To try a generated box before uploading it to the cloud follow these commands.

1) Add locally the generated box:

    ```shell
    vagrant box add --force --provider=vmware_desktop vyoco-dev file:///Users/shared/Workspace/builds/vyoco_vmware-iso_0.0.4.box
    vagrant box list
    ```

2) Create a Vagrantfile:

    ```shell
    cd test/local
    vagrant init vyoco-dev
    ```

3) Start your virtual machine and check its status:

    ```shell
    vagrant up --provider=vmware_desktop
    vagrant status
    ```

4) Clone a specific and only specific branch of yocto:

    ```shell
    vagrant ssh -c "cd ~/workspace && source source/clone_poky.sh"
    ```

5) Connect via ssh:

    ```shell
    vagrant ssh
    ```

## Custom box

For a custom vagrant cloud box please follow these steps:

1) Sing up and generate a token on <app.vagrantcloud.com>
2) In the file "vagrant_cloud.auto.pkrvars.hcl", set variable:
    * "vagrant_cloud_account" with your account
    * "vagrant_cloud_box_version" with your current version number
    * "vagrant_cloud_box_description" with a version description text
3) In the file "boxes/ubuntu/22.4/yocto.pkrvars.hcl, extend variables with your identifier:
    * "yocto_packages" with a list of tools to be installed for your yocto version
    * "yocto_poky_rev" with a revision/branch/tag to be cloned
4) Set an environment variable "PKR_VAR_VAGRANT_CLOUD_TOKEN" with a generated token.

## Pimp your machine

### Extend a disk size

Before we will start let's check a current disk usage:

```shell
vagrant@vyoco:~$ lsblk /dev/sda
NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                         8:0    0  200G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    2G  0 part /boot
└─sda3                      8:3    0  198G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 99.3G  0 lvm  /
sudo vgs
  VG        #PV #LV #SN Attr   VSize    VFree  
  ubuntu-vg   1   1   0 wz--n- <198.00g <98.71g
```

The size of the disk sda3 is 198GB, but currently allocated 99.3GB and we see
99 GB free (my bad I have to check the installation later). Let's extend with
a whole free size:

```shell
vagrant@vyoco:~$ sudo lvextend  -l+100%FREE /dev/ubuntu-vg/ubuntu-lv
  Size of logical volume ubuntu-vg/ubuntu-lv changed from <99.29 GiB (25418 extents) to <198.00 GiB (50687 extents).
  Logical volume ubuntu-vg/ubuntu-lv successfully resized.
```

Now let's use it:

```shell
vagrant@vyoco:~$ df -hPT /
Filesystem                        Type  Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv ext4   97G  8.0G   84G   9% /

vagrant@vyoco:~$ sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/ubuntu-vg/ubuntu-lv is mounted on /; on-line resizing required
old_desc_blocks = 13, new_desc_blocks = 25
The filesystem on /dev/ubuntu-vg/ubuntu-lv is now 51903488 (4k) blocks long.

vagrant@vyoco:~$ df -hPT /
Filesystem                        Type  Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv ext4  195G  8.0G  178G   5% /
```

The disk size have changed from 97GB to 195GB and has 178GB available.

If this is still not enough, you must first shut down your machine
and then increase the hard disk size in the virtual machine settings.
