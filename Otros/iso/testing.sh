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





if grep -q "prog     Tienda de apps(plasma-discover)  /usr/share/icons/Tela-grey-dark/scalable/apps/plasmadiscover.svg    plasma-discover" /etc/skel/.icewm/toolbar 
then
	echo "::::: Existe, omitiendo este paso..."
else

	echo "prog     Tienda de apps(plasma-discover)  /usr/share/icons/Tela-grey-dark/scalable/apps/plasmadiscover.svg    plasma-discover" >> /etc/skel/.icewm/toolbar 
	echo "prog     Tienda de apps(plasma-discover)  /usr/share/icons/Tela-grey-dark/scalable/apps/plasmadiscover.svg    plasma-discover" >> /home/live/.icewm/toolbar

fi

if grep -q "prog     Browser(Librewolf)  /usr/share/icons/hicolor/scalable/apps/librewolf.svg    librewolf" /etc/skel/.icewm/toolbar 
then
	echo "::::: Existe, omitiendo este paso..."
else

	echo "prog     Browser(Librewolf)  /usr/share/icons/hicolor/scalable/apps/librewolf.svg    librewolf" >> /etc/skel/.icewm/toolbar 
	echo "prog     Browser(Librewolf)  /usr/share/icons/hicolor/scalable/apps/librewolf.svg    librewolf" >> /home/live/.icewm/toolbar

fi


sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
apt purge kdeconnect

