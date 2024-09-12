#!/usr/bin/env bash


source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	
	echo "sysVinit"

fi



if [ "systemd" == "${init}" ]
then

		echo "systemd"

fi

echo "#########################################"










if [ "systemd" == "${init}" ]
then
	
	echo ":: calamares para systemd"
	apt -y install ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb calamares live-config-systemd calamares-settings-debian \
	live-boot live-config-doc  live-config live-tools live-boot-initramfs-tools
	apt -y install network-manager-gnome
	
else 
	
	echo ":: calamares para sysvinit"
	
	
	apt -y install live-config-sysvinit live-boot live-config-doc  live-config live-tools live-boot-initramfs-tools
	apt -y install calamares calamares-settings-loc-os 
	apt -y install glpkg

fi

## ISO Tools
apt -y install xorriso genisoimage squashfs-tools

dpkg -i ./refractaSnapshot/refractasnapshot-base_10.2.12_all.deb


