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


##### LIGHTDM: DEPENDENCIA
apt -y install numlockx

## LIGHTDM: INSTALACION
apt -y install lightdm lightdm-gtk-greeter --no-install-recommends 

##### LIGHTDM: AUTOLOGIN LIVE
sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf

##### LIGHTDM: BLOQ NUM ACTIVADO POR DEFECTO
sed -i '/greeter-setup-script=/c greeter-setup-script=/usr/bin/numlockx on' /etc/lightdm/lightdm.conf

##### LIGHTDM: MOSTAR USUARIOS DISPONIBLES
sed -i '/greeter-hide-users=/c greeter-hide-users=false' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 

##### LIGHTDM: WALLPAPER
sed -i '/background =/c background = /usr/share/wallpapers/loquitux_orquidea.png'  /etc/lightdm/lightdm-gtk-greeter.conf

