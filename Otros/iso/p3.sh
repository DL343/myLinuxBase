#!/usr/bin/env bash

source ./variables.sh

dhclient


if [ "sysvinit" == "${init}" ]
then
	echo "
	############################################################
	################## LIMPIEZA DE SYSTEMD #################### 
	############################################################
	"
	apt -y purge *systemd*  
	update-grub
	
fi

echo "
############################################################
############ AJUSTE ESTANDAR DE REPOSITORIOS ###############
############################################################
"
cp ./apt/sources.list /etc/apt/

cp ./apt/sources-final /sbin/

cp ./apt/sources-media /sbin/

apt update

#reboot
