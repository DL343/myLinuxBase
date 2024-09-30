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




##### STARTUP
if grep -q -x "dbus-update-activation-environment DISPLAY &" $HOME/.icewm/startup
then
	echo "::::: Existe 'dbus-update-activation-environment DISPLAY &', omitiendo este paso..."
else
echo "
## Ajuste sin DM
dbus-update-activation-environment DISPLAY &
" >> $HOME/.icewm/startup
fi





