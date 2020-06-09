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

# Download Mental Outlaw's Gentoo scripts
wget --verbose 'https://github.com/sguzman/deploygentoo/archive/master.zip'
unzip gentootestscript-master.zip

mkdir /mnt/gentoo/etc/portage/defaults
mv /mnt/gentoo/etc/portage/make.conf /mnt/gentoo/etc/portage/defaults/
cp ./gentootestscript-master/gentoo/portage/my.minimal.conf /mnt/gentoo/etc/portage/make.conf

cp ./gentootestscript-master/gentoo/kernel/gentoohardenedminimal /mnt/gentoo/gentoohardenedminimal

