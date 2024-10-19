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


##### FLATPAK

sudo apt -y install   htop   btop   fastfetch   p7zip-full   lm-sensors inxi  \
lxappearance    lxrandr   \
parcellite 	    rofi  		nitrogen	redshift	 \
plasma-discover   




sudo apt -y install volumeicon-alsa   numlockx   xdg-desktop-portal




flatpak install flathub org.flameshot.Flameshot
flatpak install flathub org.nomacs.ImageLounge
flatpak install flathub org.bleachbit.BleachBit
flatpak install flathub io.mpv.Mpv
flatpak install flathub org.gnome.Evince
flatpak install flathub org.geany.Geany
flatpak install flathub io.gitlab.librewolf-community


