vbox
====

Packer definitions to generate Vagrant boxes for:

    - CentOS 7.0
    - CentOS 6.5
    - Fedora 20

How to Build
------------

First download and install [Packer](http://www.packer.io). Now build the
Vagrant boxes:

    vbox.git jpeach$ packer build trafficserver.json
    fedora-20 output will be in this color.
    centos-7.0 output will be in this color.
    centos-6.5 output will be in this color.
    ...

After a while, packer will finish and the Vagrant boxes will be
placed in the `boxes/` subdirectory.

    vbox.git jpeach$ ls boxes/
    centos-6.5-x64-virtualbox.box	centos-7.0-x64-virtualbox.box	fedora-20-x64-virtualbox.box

Now, you can import them into Vagrant using the [vagrant
box](https://docs.vagrantup.com/v2/cli/box.html) command:

    vbox.git jpeach$ vagrant box add --force jpeach/fedora-20 ./boxes/fedora-20-x64-virtualbox.box
    ...
    ==> box: Successfully added box 'jpeach/fedora-20' (v0) for 'virtualbox'!
