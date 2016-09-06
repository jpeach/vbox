#! /bin/bash

. /etc/os-release

echo Installing YUM repository for puppet ...
case $VERSION_ID in
    23|24)
    cat > /etc/yum.repos.d/puppet.repo <<EOF
[puppetlabs]
name = Puppet Labs
baseurl = https://yum.puppetlabs.com/fedora/f${VERSION_ID}/PC1/\$basearch
gpgkey = https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
enabled = 1
gpgcheck = 1
EOF
    ;;
    22)
    rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-fedora-22.noarch.rpm
    ;;
esac

echo Installing puppet ...
dnf install -v -y puppet-agent

echo Symlinking puppet binaries into /usr/sbin ...
for prog in /opt/puppetlabs/bin/* ; do
    ln -sf $prog /usr/sbin/$(basename $prog)
done

echo Installing well-known vagrant SSH key ...
(
    cd ~vagrant

    mkdir -p .ssh
    curl -o .ssh/authorized_keys -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'

    chmod 700 .ssh
    chmod 600 .ssh/authorized_keys
    chown -R vagrant:vagrant .ssh
)

echo Installing VirtualBox guest additions ...
(
    cd ~vagrant
    rm -f /var/log/vboxadd-install.log

    if [ -r VBoxGuestAdditions.iso ] ; then
        mount -o loop $(pwd)/VBoxGuestAdditions.iso /mnt

        /mnt/VBoxLinuxAdditions.run --nox11

        # If the build failed, puke some diagnostics ...
        if [ "$?" -ne "0" ] ; then
            cat /var/log/vboxadd-install.log
            rpm -qa | grep kernel
            echo kernel version is $(uname -r)
            ls /lib/modules/$(uname -r)
        fi

        umount /mnt
        rm VBoxGuestAdditions.iso
    fi
)

