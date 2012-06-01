# Install, not upgrade
install

# Install from a friendly mirror and add updates
url --url=http://fedora.mirror.lstn.net/releases/17/Fedora/x86_64/os/
repo --name=updates

# Language and keyboard setup
lang en_US.UTF-8
keyboard us

# Configure DHCP networking w/optional IPv6, firewall on
network --onboot yes --device eth0 --bootproto dhcp --ipv6 auto --hostname fedora.local
firewall --service=ssh

# Set timezone
timezone --utc Etc/UTC

# Authentication
rootpw qwerty
authconfig --enableshadow --passalgo=sha512

# SELinux
selinux --enforcing

# Services running at boot
services --enabled network,sshd
services --disabled sendmail

# Disable anything graphical
skipx
text

# Setup the disk
zerombr
clearpart --all --drives=xvda
part / --fstype=ext4 --grow --size=1024 --asprimary
part swap --size=512
bootloader --location=none --timeout=5 --driveorder=xvda

# Shutdown when the kickstart is done
halt

# Minimal package set
%packages --excludedocs
man
man-pages
sendmail
yum-presto
yum-updatesd
%end

# Add in an old-style grub.conf to make XenServer's pygrub happy
%post
KERNELSTRING=`rpm -q kernel --queryformat='%{VERSION}-%{RELEASE}.%{ARCH}\n' | tail -n 1`

cat > /boot/grub/grub.conf <<EOF
default=0
timeout=5
title Fedora (${KERNELSTRING})
	root (hd0,0)
	kernel /boot/vmlinuz-${KERNELSTRING} ro root=/dev/xvda1 console=hvc0 quiet
	initrd /boot/initramfs-${KERNELSTRING}.img
EOF

ln -s /boot/grub/grub.conf /boot/grub/menu.lst
ln -s /boot/grub/grub.conf /etc/grub.conf

%end

