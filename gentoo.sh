#!/bin/bash

# Following Mental Outlaw's Intalling Gentoo video
echo 'Gentoo Installation script'

# Set up partition scheme for Gentoo
cfdisk /dev/sda

# Format partitions
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2

# Mount freshly made partition on current host
mount /dev/sda2 /mnt/gentoo

cd /mnt/gentoo
# Download hardened Stage 3 Tar
wget --verbose 'https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20200607T214504Z/hardened/stage3-amd64-hardened-20200607T214504Z.tar.xz'
#UnTar Stage 3
tar xpvf stage3-amd64-hardened-20200607T214504Z.tar.xz --xattrs-include='*.*' --numeric-owner

ntpd -q -g

mkdir --parents /mnt/gentoo/etc/portage/defaults
mv /mnt/gentoo/etc/portage/make.conf /mnt/gentoo/etc/portage/defaults/
cp /local/gentoo/portage/my.minimal.conf /mnt/gentoo/etc/portage/make.conf

cp /local/gentoo/kernel/gentoohardenedminimal /mnt/gentoo/gentoohardenedminimal

mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf

mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolve.conf /mnt/gentoo/etc/resolve.conf

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

chroot /mnt/gentoo ./gentootestscript-master/chroot.sh
##### Chroot from here on now