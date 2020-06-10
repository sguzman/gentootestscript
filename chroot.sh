#!/bin/bash -x

echo 'Entered Chroot'
set -e

source /etc/profile
export PS1="(chroot) ${PS1}"

emerge-webrsync --verbose --debug
emerge --verbose --update --deep --newuse @world

ls /usr/share/zoneinfo
echo "America/Los_Angeles" > /etc/timezone
emerge --verbose --config sys-libs/timezone-data

eselect profile list


echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
echo 'LANG="en_US.UTF-8"' > /etc/env.d/02locale
echo 'LC_COLLATE="C"' >> /etc/env.d/02locale

locale-gen
eselect locale list

env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

emerge --verbose sys-kernel/gentoo-sources lz4 app-arch/lz4 sys-apps/pciutils

ls -l /usr/src/linux
cd /usr/src/linux
cp /gentoohardenedminimal /usr/src/linux/.config

(
	echo 1
) | make oldconfig

make
make modules_install

echo '/dev/sda1\t\t/boot\t\text4\t\tdefaults,noatime 0 2' >> /etc/fstab
echo '/dev/sda2\t\t/\t\text4\t\tnoatime 0 1' >> /etc/fstab

echo 'hostname="Wittgenstein"' > /etc/conf.d/hostname

emerge --verbose --noreplace net-misc/netifrc

ifconfig
echo 'config_enp5s0="dhcp"' > /etc/conf.d/net
ln -s /etc/init.d/net.lo net.enp5s0
rc-update net.enp5s0 default

echo '127.0.01\twittgenstein' >> /etc/hosts
echo '::1\twittgenstein' >> /etc/hosts

echo 'admin' | passwd

emerge --verbose app-admin/sysklogd
rc-update add sysklogd default
emerge --verbose sys-apps/mlocate
emerge --verbose net-misc/dhcdcd

emerge --verbose sys-boot/grup:2
grub-install /dev/sda
grup-mkconfig -o /boot/grub/grub.cfg


#exit
bash