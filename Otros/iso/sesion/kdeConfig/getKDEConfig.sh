#!/bin/bash


rm -r ./ZZZCapturado/*
mkdir -p ./ZZZCapturado/.config/

cp /home/live/.gtkrc-2.0   ./ZZZCapturado


echo "#########################"
ubiScript=$(pwd)
echo "$ubiScript"
echo "#########################"


echo "#########################"
contenedor="$ubiScript/ZZZCapturado/.config/"
echo "$contenedor"
echo "#########################"


cd /home/live/.config/
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/  akregatorrc  kactivitymanagerdrc  kcminputrc  kconf_updaterc  kded5rc  kdeglobals  kmixrc  krunnerrc  kscreenlockerrc  ksmserverrc    kwalletrc  kwinrc  kwinrulesrc  kxkbrc  plasma-localerc  plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc  powerdevilrc  powermanagementprofilesrc  $contenedor

#echo $contenedor

cd $ubiScript

pwd
