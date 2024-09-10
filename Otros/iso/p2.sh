#!/usr/bin/env bash


source ./variables.sh

########################################################################
############################# ¿SYSVINIT? ###############################
########################################################################

if [ "sysvinit" == "${init}" ]
then

	apt -y install wget

	############################################################
	################# INSTALACION DE SYSVINIT ################## 
	############################################################
	apt update
	apt -y install sysvinit-core sysvinit-utils


	############################################################
	############# INSTALACION REPOSITORIO LOC-OS ############### 
	############################################################
	wget -O /tmp/loc-os-23-keyring.deb http://fr.loc-os.com/pool/main/l/loc-os-23-archive-keyring/loc-os-23-archive-keyring_23.12.11_all.deb
	dpkg -i /tmp/loc-os-23-keyring.deb
	rm /tmp/loc-os-23-keyring.deb

	apt update
	apt -y upgrade

	############################################################
	################ AJUSTE DE LSB-RELEASE #################### 
	############################################################
	touch /etc/lsb-release
	chmod 777 /etc/lsb-release
echo "PRETTY_NAME='Loc-OS Linux 23'
DISTRIB_ID=Loc-OS
DISTRIB_RELEASE=23
DISTRIB_CODENAME='Con Tutti'
DISTRIB_DESCRIPTION='Loc-OS Linux 23'" > /etc/lsb-release

	############################################################
	#################### BLOQUEO SYSTEMD ###################### 
	############################################################
	touch /etc/apt/preferences.d/00systemd
	chmod 777 /etc/apt/preferences.d/00systemd

	echo "Package: *systemd*:any
	Pin: origin *
	Pin-Priority: -1" > /etc/apt/preferences.d/00systemd


	############################################################
	######### COMPILACION ULTIMA VERSION SYSVINIT ############## 
	############################################################
	mkdir -p /opt/Loc-OS-LPKG/lpkgbuild/remove/
	touch /opt/Loc-OS-LPKG/lpkgbuild/remove/lpkgbuild-64.list
	wget -O /sbin/lpkgbuild https://gitlab.com/loc-os_linux/lpkgbuild/-/raw/main/lpkgbuild
	chmod +x /sbin/lpkgbuild
	lpkgbuild update
	lpkgbuild install sysvinit-3.10
	rm /opt/Loc-OS-LPKG/lpkgbuild/remove/*



	############################################################
	#################### CAMBIO DEL KERNEL ###################### 
	############################################################
	KERNEL=5.10.225-loc-os
	apt -y install linux-image-$KERNEL linux-headers-$KERNEL
	apt -y purge apparmor qemu-guest-agent
	rm -r /etc/apparmor.d/
	apt -y install libeudev1

	apt -y purge linux-image-6.1* --autoremove

	update-grub




	#reboot


fi
