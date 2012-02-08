cdrom
#install
url --url=http://mirror.rackspace.com/fedora/releases/16/Fedora/x86_64/os/
lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --ipv6 auto --hostname fedora.local
timezone --utc Etc/UTC
rootpw  qwerty
selinux --enforcing
authconfig --enableshadow --passalgo=sha512
firewall --service=ssh
skipx
text
zerombr

clearpart --all --drives=xvda
part / --fstype=ext4 --grow --size=1024 --asprimary
part swap --size=512

bootloader --location=none --timeout=5 --driveorder=xvda
halt

%packages --nobase --excludedocs
@core
yum
rpm
e2fsprogs
openssh-server
grub2
lvm2

%end

%post
(
KERNELSTRING=`rpm -q kernel --queryformat='%{VERSION}-%{RELEASE}.%{ARCH}' | tail -n 1`

cat > /boot/grub/grub.conf <<EOF
default=0
timeout=5
title Fedora (${KERNELSTRING})
	root (hd0,0)
	kernel /boot/vmlinuz-${KERNELSTRING} ro root=/dev/xvda1 console=hvc0
	initrd /boot/initramfs-${KERNELSTRING}.img
EOF

ln -s /boot/grub/grub.conf /boot/grub/menu.lst
ln -s /boot/grub/grub.conf /etc/grub.conf
) 1>/post_install.log 2>&1

%end