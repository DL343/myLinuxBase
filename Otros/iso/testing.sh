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



if grep -q "CUSTOM KDE" /usr/lib/refractasnapshot/snapshot_exclude.list
then
	echo ":::::'CUSTOM KDE' existe, omitiendo este paso....."
else
echo "

####### CUSTOM KDE ########
- /home/*/.config/kate
- /home/*/.config/akregatorrc
- /home/*/.config/dolphinrc
- /home/*/.config/gwenviewrc
- /home/*/.config/katerc
- /home/*/.config/kmixrc
- /home/*/.config/konsolerc
- /home/*/.config/konquerorrc
- /home/*/.config/kwinrc
- /home/*/.config/spectaclerc

- /home/*/.local/share/dolphin/*
- /home/*/.local/share/kate/*
- /home/*/.local/share/klipper/*
- /home/*/.local/share/kscreen/*

" >> /usr/lib/refractasnapshot/snapshot_exclude.list
fi

