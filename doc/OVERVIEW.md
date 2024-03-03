# Getting started

## Configuration

### Virtual hardware

The current setting is for i9-13th generation, please adjust it to the values of your
host system. Adjust following variables in the file "variables.pkr.hcl" :

    cpus
    memory
    disk_size

### Change password

Default user and password is "vagrant", to change the password proceed this command

    python3 -c 'import crypt; print(crypt.crypt("vagrant", crypt.mksalt(crypt.METHOD_SHA512)))'

and exchange the result with a current content in a file "boxes/ubuntu/22_04/data/user-data", part "identity->password"

### Build optimization(s)

To do not download each time the Ubuntu iso image you can store an expected image into
a subdirectory "iso":

    https://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso

## Build

Proceed following commands to build virtual machine and a vagrant box

    packer init .
    packer validate -var-file="boxes/ubuntu/22_04/pkrvars/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22_04/pkrvars/yocto_4.0.16.pkrvars.hcl" .
    packer build -on-error=ask -only='build_vyoco.*' -var-file="boxes/ubuntu/22_04/pkrvars/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22_04/pkrvars/yocto_4.0.16.pkrvars.hcl" .

After succefull build will be created two files which can be uploaded
to app.vagrantup.com:

    * vyoco_vmware-iso_X.X.X.box - vagrant box 
    * vyoco_vmware-iso_X.X.X.box.sha512 - file with a checksum for the vagrant vmware box 

To upload the box to a vagrant cloud box "richandrysek/vyoco" proceed this command:

    packer build -on-error=ask -only='upload_vyoco.*' -var-file="boxes/ubuntu/22_04/pkrvars/vmware.pkrvars.hcl" -var-file="boxes/ubuntu/22_04/pkrvars/yocto_4.0.16.pkrvars.hcl" .

## Debugging a box before uploading

To try a generated box before uploading it to the cloud follow these commands.

1) Add locally the generated box

    vagrant box add --provider=vmware_desktop vyoco-dev file:///Users/shared/Workspace/builds/vyoco_vmware-iso_0.0.1.box

2) Create a Vagrantfile

    vagrant init vyoco-dev

3) Start your virtual machine

    vagrant up --provider=vmware_desktop

4) Connect via ssh

    vagrant ssh

## Custom box

For a custom vagrant cloud box please follow these steps:

1) Sing up and generate a token on app.vagrantcloud.com
2) In the file "vagrant_cloud.auto.pkrvars.hcl", set variable:
    * "vagrant_cloud_account" with your account
    * "vagrant_cloud_box_version" with your current version number
    * "vagrant_cloud_box_description" with a version description text
3) In the file "boxes/ubuntu/22_04/pkrvars/yocto_4.0.16.pkrvars.hcl, set variable:
    * "yocto_tools" with a list of tools to be installed for your yocto version
    * "yocto_poky_rev" with a revision/branch/tag to be cloned
4) Set an environment variable "PKR_VAR_VAGRANT_CLOUD_TOKEN" with a generated token.