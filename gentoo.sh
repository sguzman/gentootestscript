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

# Download Mental Outlaw's Gentoo scripts
wget --verbose 'https://github.com/MentalOutlaw/deploygentoo/archive/master.zip'
unzip gentootestscript-master.zip

#UnTar Stage 3
tar xpvf stage3-amd64-hardened-20200607T214504Z.tar.xz --xattrs-include='*.*' --numeric-owner

mkdir /mnt/gentoo/etc/portage/defaults
mv /mnt/gentoo/etc/portage/make.conf /mnt/gentoo/etc/portage/defaults/
cd gentootestscript-master/gentoo/
unzip portage.zip





