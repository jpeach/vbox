#! /bin/bash

echo Installing YUM repositories for puppet and EPEL ..
case $(cat /etc/redhat-release) in
    *7.[0-9]*)
        rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
        rpm -ivh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm
        ;;
    *6.[0-9]*)
        rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rp
        rpm -ivh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
        ;;
    *5.[0-9]*)
        rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm
        rpm -ivh http://download.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
        ;;
esac

echo Installing puppet ...
yum install -y puppet

echo Installing well-known vagrant SSH key ...
(
    cd ~vagrant

    mkdir .ssh
    touch .ssh/authorized_keys

    curl -o .ssh/authorized_keys -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

    chmod 700 .ssh
    chmod 600 .ssh/authorized_keys
    chown -R vagrant:vagrant .ssh
)
