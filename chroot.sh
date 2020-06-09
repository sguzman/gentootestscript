#!/bin/bash -x

source /etc/profile
export PS1="(chroot) ${PS1}"

mount /dev/sda1 /boot
emerge-webrsync

eselect profile list
emerge --ask --verbose --update --deep --newuse @world

ls /usr/share/zoneinfo
echo "America/Los_Angeles" > /etc/timezone

nano -w /etc/locale.gen
locale-gen
eselect locale list
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
