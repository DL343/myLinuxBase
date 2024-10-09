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
 
apt -y install connman



echo "
########################################################################
############################ PREFIX CALAMARES ########################### 
########################################################################
"

echo "
#!/bin/sh
#
# Writes the final sources.list file
#

CHROOT=$(mount | grep proc | grep calamares | awk '{print $3}' | sed -e "s#/proc##g")
RELEASE=\"bookworm\"

cat << EOF > $CHROOT/etc/apt/sources.list
# See https://wiki.debian.org/SourcesList for more information.
deb http://deb.debian.org/debian $RELEASE main contrib non-free-firmware
## deb-src http://deb.debian.org/debian $RELEASE main contrib non-free-firmware

deb http://deb.debian.org/debian $RELEASE-updates main
## deb-src http://deb.debian.org/debian $RELEASE-updates main

deb http://security.debian.org/debian-security/ $RELEASE-security main
## deb-src http://security.debian.org/debian-security/ $RELEASE-security main
EOF

exit 0

" > /sbin/sources-final



cat << 'EOF' > /sbin/sources-media
#!/bin/sh

CHROOT=$(mount | grep proc | grep calamares | awk '{print $3}' | sed -e "s#/proc##g")
MEDIUM_PATH="/run/live/medium"
RELEASE="bookworm"

if [ "$1" = "-u" ]; then
    umount $CHROOT/$MEDIUM_PATH
    rm $CHROOT/etc/apt/sources.list.d/debian-live-media.list
    chroot $CHROOT apt-get update
    exit 0
fi

# Remove the base sources, we will configure sources in a later phase
rm -f $CHROOT/etc/apt/sources.list.d/base.list

mkdir -p $CHROOT/$MEDIUM_PATH
mount --bind $MEDIUM_PATH $CHROOT/$MEDIUM_PATH
echo "deb [trusted=yes] file:$MEDIUM_PATH $RELEASE main" > $CHROOT/etc/apt/sources.list.d/debian-live-media.list
echo "QT_QPA_PLATFORMTHEME=gtk2" > $CHROOT/etc/environment
chroot $CHROOT apt-get update
# Attempt safest way to remove cruft
rmdir $CHROOT/run/live/medium
rmdir $CHROOT/run/live

exit 0

EOF


