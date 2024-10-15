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



plasmaDiscover="prog     Tienda de apps(plasma-discover)  /usr/share/icons/Tela-grey-dark/scalable/apps/plasmadiscover.svg    plasma-discover"

if grep -q "$plasmaDiscover" /etc/skel/.icewm/toolbar 
then
	echo "::::: Existe, omitiendo este paso..."
else

	echo "$plasmaDiscover" >> /etc/skel/.icewm/toolbar 
	echo "$plasmaDiscover" >> /home/live/.icewm/toolbar

fi

librewolf="prog     Browser(Librewolf)  /usr/share/icons/hicolor/128x128/apps/librewolf.png    librewolf"

if grep -q "$librewolf" /etc/skel/.icewm/toolbar 
then
	echo "::::: Existe, omitiendo este paso..."
else

	echo "$librewolf" >> /etc/skel/.icewm/toolbar 
	echo "$librewolf" >> /home/live/.icewm/toolbar

fi


sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
apt purge kdeconnect

