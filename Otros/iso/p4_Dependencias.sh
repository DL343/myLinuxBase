#!/usr/bin/env bash

source ./variables.sh

apt update
apt upgrade

echo "
########################################################################
############################ APPS NECESARIAS ########################### 
########################################################################
"



if [ "systemd" == "${init}" ]
then
	
	echo ":: calamares para systemd"
	apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb calamares calamares-settings-debian live-config-systemd 
		
		
else 
	
	echo ":: calamares para sysvinit"
	apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb calamares calamares-settings-loc-os live-config-sysvinit
	
	apt -y install glpkg

fi


## LiveTools
apt -y install live-boot live-config-doc live-config live-tools live-boot-initramfs-tools


## ISO Tools
apt -y install xorriso genisoimage squashfs-tools

## GVFS
apt -y install gvfs-common gvfs-daemons gvfs-libs gvfs

## SYSLinux
apt -y install syslinux syslinux-common

## Grub
apt -y install grub-efi grub-pc-bin

## GNUStep
apt -y install gnustep-base-common gnustep-base-runtime gnustep-common

## Polkit
apt -y install policykit-1 polkitd-pkla p11-kit

## Firmwares
apt -y install firmware-atheros firmware-b43-installer firmware-brcm80211 firmware-iwlwifi firmware-libertas firmware-linux-nonfree firmware-linux firmware-misc-nonfree firmware-qlogic firmware-realtek-rtl8723cs-bt firmware-realtek firmware-samsung

## Misc. Tools
apt -y install xorg zenity xapps-common uno-libs-private toilet tree unar caca-utils acl btrfs-progs cryptsetup gcr  gparted lynx mtools ntpsec user-setup yad libduktape207 mlocate keyutils
 
apt -y install connman connman-gtk
