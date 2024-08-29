#!/usr/bin/env bash


echo "
# See https://wiki.debian.org/SourcesList for more information.
deb http://deb.debian.org/debian bookworm main contrib non-free-firmware
#deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian bookworm-updates main
#deb-src http://deb.debian.org/debian bookworm-updates main

deb http://security.debian.org/debian-security/ bookworm-security main
#deb-src http://security.debian.org/debian-security/ bookworm-security main
" > /etc/apt/sources.list

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
deb-src http://deb.debian.org/debian $RELEASE main contrib non-free-firmware

deb http://deb.debian.org/debian $RELEASE-updates main
deb-src http://deb.debian.org/debian $RELEASE-updates main

deb http://security.debian.org/debian-security/ $RELEASE-security main
deb-src http://security.debian.org/debian-security/ $RELEASE-security main
EOF

exit 0
" > /sbin/sources-final 


echo "
#!/bin/sh

CHROOT=$(mount | grep proc | grep calamares | awk '{print $3}' | sed -e "s#/proc##g")
MEDIUM_PATH=\"/run/live/medium\"
RELEASE=\"bookworm\"

if [ \"$1\" = \"-u\" ]; then
    umount $CHROOT/$MEDIUM_PATH
    rm $CHROOT/etc/apt/sources.list.d/debian-live-media.list
    chroot $CHROOT apt-get update
    exit 0
fi

# Remove the base sources, we will configure sources in a later phase
rm -f $CHROOT/etc/apt/sources.list.d/base.list

mkdir -p $CHROOT/$MEDIUM_PATH
mount --bind $MEDIUM_PATH $CHROOT/$MEDIUM_PATH
echo \"deb [trusted=yes] file:$MEDIUM_PATH $RELEASE main\" > $CHROOT/etc/apt/sources.list.d/debian-live-media.list
echo \"QT_QPA_PLATFORMTHEME=gtk2\" > $CHROOT/etc/environment
chroot $CHROOT apt-get update
# Attempt safest way to remove cruft
rmdir $CHROOT/run/live/medium
rmdir $CHROOT/run/live

exit 0
" > /sbin/sources-media

apt update


reboot
