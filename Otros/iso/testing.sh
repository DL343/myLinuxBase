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


















###### SDDM: INSTALACION
#apt install sddm --no-install-recommends 


###### SDDM: CONFIGURACION
#echo "
#[Theme]
## Current theme name
#Current=breeze



#[Autologin]
#User=live
#Session=icewm-session

#" > /etc/sddm.conf

###### SDDM: APLICANDO TEMA
#mkdir -p /usr/share/sddm/themes
#cp -r ./custom/dm/breeze/    /usr/share/sddm/themes/

###### SDDM: APLICANDO IMAGEN PERFIL USUARIO
#cp  ./custom/dm/face.png   /home/live/.face.icon  
#cp  ./custom/dm/face.png   /etc/skel/.face.icon 


###### SDDM: WALLPAPER CUSTOM
#echo "
#[General]
#background=/usr/share/wallpapers/loquitux_orquidea.png 
#" > /usr/share/sddm/themes/breeze/theme.conf.user




echo "
########################################################################
                              TIENDA APPS
########################################################################
"
##### PLASMA-DISCOVER
sudo apt install breeze-icon-theme plasma-discover qml-module-org-kde-purpose libkf5purpose-dev    
apt -y purge kdeconnect


##### SYSVINIT: ACTUALIZACION DE REPOSITORIOS AL ARRANQUE
echo '### BEGIN INIT INFO
# Provides:          apt-update
# Required-Start:    $local_fs $remote_fs lightdm
# Required-Stop:     $local_fs $remote_fs lightdm
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: apt update on startup
# Description:       apt update on startup
#                    
#                    
### END INIT INFO


case "$1" in
    start)
        echo "Starting Repository updater: apt update"
        (apt-get update > /var/log/apt-update.log 2>&1) &
        ;;
    stop)
        #
        ;;
    *)
        echo "Usage: /etc/init.d/apt-update {start|stop}"
        exit 1
        ;;
esac

exit 0

' > /etc/init.d/apt-update

chmod +x /etc/init.d/apt-update

sudo update-rc.d apt-update defaults 






if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	echo "Perfecto!, existe la configracion, omitiendo este paso...";

else 

   echo "No existe la configuracion, aplicando...."
   sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi


