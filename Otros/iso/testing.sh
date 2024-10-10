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

if grep -q "background=/usr/share/wallpapers/loquitux_orquidea.png" /etc/lightdm/lightdm-gtk-greeter.conf
then

	echo "Existe ajuste, omitiendo este paso"

else

echo "
background=/usr/share/wallpapers/loquitux_orquidea.png
theme-name=DarkAndGolden
icon-theme-name=Tela-grey-dark
" >> /etc/lightdm/lightdm-gtk-greeter.conf

fi
