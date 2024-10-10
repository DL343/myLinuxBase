#!/usr/bin/env bash

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
' | sudo tee /etc/skel/.config/scripts/toggle_network-applet.sh 



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




echo "
########################################################################
##########################  PERSONALIZACION  ###########################
########################################################################
"	

## TEMAS
mkdir -p /usr/share/themes/
cp -r ./custom/themes/*      /usr/share/themes/

## ICONOS + CURSOR
mkdir -p /usr/share/icons/
cp -r ./custom/icons/*      /usr/share/icons/

## APLICANDO...
cp ./custom/gtk/.gtkrc-2.0     /etc/skel/.gtkrc-2.0
cp ./custom/gtk/.gtkrc-2.0     /home/live/.gtkrc-2.0


mkdir -p /etc/skel/.config/gtk-3.0/
mkdir -p /home/live/.config/.config/gtk-3.0/
cp ./custom/gtk/settings.ini    /etc/skel/.config/gtk-3.0/settings.ini
cp ./custom/gtk/settings.ini    /home/live/.config/gtk-3.0/settings.ini


## IMAGEN PERFIL USUARIO
cp ./custom/face/*      /etc/skel/.face
cp ./custom/face/*      /home/live/.face

## ------------------------------

## WALLPAPER PRINCIPAL
mkdir -p /usr/share/wallpapers/
cp ./custom/wall/* /usr/share/wallpapers/default.png

## WALLPAPER'S COMPLEMENTARIOS
cp ./custom/wallpapers/* /usr/share/wallpapers/


## COLORES
## /usr/share/color-schemes/





echo "
########################################################################
########################## DISPLAY MANAGER #############################
########################################################################
"

## LXDM
apt -y install lxdm 
apt -y install lxdm-loc-os

sed -i '/session=/c session=/usr/bin/icewm-session' /etc/lxdm/default.conf
sed -i '/numlock=/c numlock=1' /etc/lxdm/default.conf




#echo "
#########################################################################
########################### DISPLAY MANAGER #############################
#########################################################################
#"
### LIGHTDM
#apt -y install lightdm lightdm-gtk-greeter 

#sed -i '/autologin-user=/c autologin-user=live' /etc/lightdm/lightdm.conf
#sed -i '/autologin-user-timeout=/c autologin-user-timeout=0' /etc/lightdm/lightdm.conf
#sed -i '/autologin-session=/c autologin-session=icewm-session' /etc/lightdm/lightdm.conf






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


echo "
########################################################################
############################## CALAMARES ##############################
########################################################################
"
## IMG: Icono 
#cp ./LO/Calamares/calamares-loc-os.png /home/live/
#

## Entrada en el escritorio
mkdir -p /home/live/Desktop/
cp ./LO/Calamares/install.desktop /home/live/Desktop/install.desktop
#


fi



update-grub
update-initramfs -u
sudo init q



