# Anaconda/kickstart documentation:
#   https://fedoraproject.org/wiki/Anaconda/Kickstart
#
# Also see this description of Fedora changes needed for kickstarting:
#   https://bugzilla.redhat.com/show_bug.cgi?id=967531

install
url --url=http://download.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os/

repo --name=fedora
repo --name=updates

# System authorization information
auth  --useshadow  --enablemd5

# Default the root password
rootpw vagrant

# Do a text-mode install
text

# Partition clearing information
clearpart --none

# Firewall configuration
firewall --enabled

# Run the Setup Agent on first boot
firstboot --disable

# System keyboard
keyboard us

# System language
lang en_US.UTF-8

# Network information
network --bootproto=dhcp --onboot=on

# SELinux configuration
selinux --disabled

# Do not configure the X Window System
skipx

# System timezone
timezone --utc America/Los_Angeles

# Clear the Master Boot Record
zerombr

# Create a vagrant user
user --name=vagrant --password=vagrant --plaintext --groups=wheel

sshpw --username=vagrant vagrant --plaintext

# Default the disk partitioning.
clearpart --all --initlabel
zerombr
autopart
bootloader --location=mbr

# Reboot after installation
reboot --eject

# Only install the group's mandatory packages, not the default selections.
%packages --ignoremissing
bzip2
deltarpm
kernel-devel
kernel-headers
yum-utils
dkms
%end

%post
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
%end
