#!/usr/bin/env bash

source ./variables.sh

apt update
apt -y upgrade


echo "
########################################################################
############################ SKEL Y LIVE ###############################
########################################################################
"

## Eliminacion rastros anteriores
rm -r /home/live/

## Creacion de la carpeta por si no existe
mkdir -p /etc/skel

## Copia de home's
cp -r ./sesion/skel/ /etc/
cp -r ./sesion/skel/ /home/live/

## Ajuste de permisos
chown live /home/live -R



echo "
########################################################################
                              AJUSTE CONNMAN
########################################################################
"

## SKEL
echo '
#!/bin/bash

if pgrep -x "connman-gtk" > /dev/null
then
        pkill connman-gtk
else
        connman-gtk &
fi
' > /etc/skel/.config/scripts/toggle_network-applet.sh 



## LIVE
echo '
#!/bin/bash

if pgrep -x "connman-gtk" > /dev/null
then
        pkill connman-gtk
else
        connman-gtk &
fi
' > /home/live/.config/scripts/toggle_network-applet.sh 


sudo chown -R live:live /home/live/





echo "
########################################################################
################################## ICEWM  ##############################
########################################################################
"	
	
apt -y install xorg
apt -y install icewm --no-install-recommends 
apt -y install sakura   connman-gtk

######## ICEWM: AJUSTE CONFIGURACIONES SOLO EN LIVE
if grep -q "pcmanfm --desktop &" /home/live/.icewm/startup
then

	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
## Escritorio
pcmanfm --desktop &

" >>  /home/live/.icewm/startup 

fi

######## ICEWM: DESHABILITAR POLKIT GNOME EN LIVE
if grep -q "#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else

	sed -i '/\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &/c #\/usr\/lib\/policykit-1-gnome\/polkit-gnome-authentication-agent-1 &' /home/live/.icewm/startup

fi





## Ajuste resolucion pantalla
##sh -c 'xrandr --output Virtual-1 --mode 1280x768' &



########## ICEWM: AJUSTE PERMISOS APAGADO/REINICIO/SUSPENSION
mkdir -p /etc/sudoers.d/

echo "
ALL ALL=(ALL) NOPASSWD: /sbin/reboot
ALL ALL=(ALL) NOPASSWD: /sbin/poweroff
ALL ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
" > /etc/sudoers.d/icewm



##### ICEWM: TOOLBAR
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


echo "
########################################################################
##########################  PERSONALIZACION  ###########################
########################################################################
"	



## APLICANDO...
cp ./custom/gtk/.gtkrc-2.0     /etc/skel/.gtkrc-2.0
cp ./custom/gtk/.gtkrc-2.0     /home/live/.gtkrc-2.0


mkdir -p /etc/skel/.config/gtk-3.0/
mkdir -p /home/live/.config/.config/gtk-3.0/
cp ./custom/gtk/settings.ini    /etc/skel/.config/gtk-3.0/settings.ini
cp ./custom/gtk/settings.ini    /home/live/.config/gtk-3.0/settings.ini



## ------------------------------



## COLORES
## /usr/share/color-schemes/





#echo "
#########################################################################
########################### DISPLAY MANAGER #############################
#########################################################################
#"

### LXDM
#apt -y install lxdm 
#apt -y install lxdm-loc-os

#sed -i '/session=/c session=/usr/bin/icewm-session' /etc/lxdm/default.conf
#sed -i '/numlock=/c numlock=1' /etc/lxdm/default.conf




echo "
########################################################################
########################## DISPLAY MANAGER #############################
########################################################################
"

##### LIGHTDM: DEPENDENCIA
apt -y install numlockx

## LIGHTDM: INSTALACION
sudo apt -y install lightdm lightdm-gtk-greeter --no-install-recommends 

##### LIGHTDM: AUTOLOGIN LIVE
sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf

##### LIGHTDM: BLOQ NUM ACTIVADO POR DEFECTO
sed -i '/greeter-setup-script=/c greeter-setup-script=/usr/bin/numlockx on' /etc/lightdm/lightdm.conf

##### LIGHTDM: MOSTAR USUARIOS DISPONIBLES
sed -i '/greeter-hide-users=/c greeter-hide-users=false' /usr/share/lightdm/lightdm.conf.d/01_debian.conf 

###### LIGHTDM: WALLPAPER
#sed -i '/background=/c background=/usr/share/wallpapers/loquitux_orquidea.png'  /etc/lightdm/lightdm-gtk-greeter.conf

###### LIGHTDM: TEMA
#sed -i '/theme-name=/c theme-name=DarkAndGolden'  /etc/lightdm/lightdm-gtk-greeter.conf

###### LIGHTDM: ICONOS
#sed -i '/icon-theme-name=/c icon-theme-name=Tela-grey-dark'  /etc/lightdm/lightdm-gtk-greeter.conf

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





########################################################################






########################################################################





########################################################################





if [ "sysvinit" == "${init}" ]
then
	
	
	## Autoinicio de Welcome para iceWM
if grep -q "/bin/loc-oswelcome.sh" /home/live/.icewm/startup
then
	echo "Existe el ajuste, omitiendo este paso..."
else
	echo "
## Script inicio
/bin/loc-oswelcome.sh

" >>  /home/live/.icewm/startup 
fi





##### LIGHTDM: AJUSTE SOLO SYSVINIT (SHUTDOWN/REBOOT/SUSPEND/HIBERNATE)
mkdir -p /etc/polkit-1/localauthority/90-mandatory.d/

echo "[Enable LightDM poweroff, reboot, suspend, hibernate (logind)]
Identity=unix-user:*
Action=org.freedesktop.login1.power-off;org.freedesktop.login1.reboot;org.freedesktop.login1.suspend;org.freedesktop.login1.hibernate
ResultAny=yes
ResultInactive=yes
ResultActive=yes
" > /etc/polkit-1/localauthority/90-mandatory.d/lightdm-enable-power-menu.pkla





fi




chown live:live -R /home/live/


update-grub
update-initramfs -u
sudo init q



