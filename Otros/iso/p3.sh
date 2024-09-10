#!/usr/bin/env bash

source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	############################################################
	################## LIMPIEZA DE SYSTEMD #################### 
	############################################################
	apt purge *systemd*  
	update-grub
	
fi

## Ajuste estandar de repositorios
cp ./apt/sources.list /etc/apt/

cp ./apt/sources-final /sbin/

cp ./apt/sources-media /sbin/

apt update

reboot
