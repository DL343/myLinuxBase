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



wget https://gitlab.com/loc-os_linux/debian12-to-loc-os23/-/raw/main/debian12-to-loc-os23.sh?ref_type=heads
chmod +x debian12-to-loc-os23.sh\?ref_type\=heads
./debian12-to-loc-os23.sh\?ref_type\=heads


