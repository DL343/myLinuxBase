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



plasmaDiscover="prog     \"Tienda de apps(plasma-discover)\"  /usr/share/icons/Tela-grey-dark/scalable/apps/plasmadiscover.svg    plasma-discover"

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


##### PLASMA-DISCOVER
sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
apt purge kdeconnect






##### SDDM: INSTALACION
apt install sddm --no-install-recommends 


##### SDDM: CONFIGURACION
echo "
[Theme]
# Current theme name
Current=breeze



[Autologin]
User=live
Session=icewm-session

" > /etc/sddm.conf

##### SDDM: APLICANDO TEMA
mkdir -p /usr/share/sddm/themes
cp -r ./custom/dm/breeze/    /usr/share/sddm/themes/

##### SDDM: APLICANDO IMAGEN PERFIL USUARIO
cp  ./custom/dm/face.png   /home/live/.face.icon  
cp  ./custom/dm/face.png   /etc/skel/.face.icon 


