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




######## ICEWM: DESHABILITAR POLKIT GNOME EN LIVE
if grep -q "#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" $HOME/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else

	sed -i '/\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &/c #\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &' $HOME/.icewm/startup

fi

