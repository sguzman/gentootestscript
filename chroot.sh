#!/bin/bash -x

source /etc/profile
export PS1="(chroot) ${PS1}"

mount /dev/sda1 /boot
emerge-webrsync --verbose --debug

eselect profile list
emerge --verbose --update --deep --newuse @world

ls /usr/share/zoneinfo
echo "America/Los_Angeles" > /etc/timezone


echo 'en_US ISO-8859-1' > /etc/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
eselect locale list

echo 'LANG="de_DE.UTF-8"' > /etc/env.d/02locale
echo 'LC_COLLATE="C"' >> /etc/env.d/02locale

env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
bash