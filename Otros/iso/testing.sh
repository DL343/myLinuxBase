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






sudo apt install breeze-icon-theme plasma-discover
sudo apt install libkf5purpose-dev  --no-install-recommends

