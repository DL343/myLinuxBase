#!/usr/bin/env bash

apt update
apt -y upgrade

apt -y purge qemu-guest-agent  #apparmor
#rm -r /etc/apparmor.d/

#apt -y install libeudev1

update-grub


reboot
