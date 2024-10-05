#!/usr/bin/env bash

echo "
########################################################################
############################### SKEL ###################################
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
############################### TTY'S ##################################
########################################################################
"

####### NUM BLOQ ACTIVADO EN TTY'S
if grep -q 'setleds -D +num < $tty' /etc/rc.local
then
	echo 'Existe "setleds -D +num < $tty", omitiendo este paso...'
else
echo '
for tty in /dev/tty[0-9]*; do
        setleds -D +num < $tty
done
' >> /etc/rc.local 

fi




########## Reduciendo numero de tty's (sysVinit)
## Ajuste al archivo
sed -i '/4:23:respawn:\/sbin\/getty/c #4:23:respawn:\/sbin\/getty 38400 tty4' /etc/inittab
sed -i '/5:23:respawn:\/sbin\/getty/c #5:23:respawn:\/sbin\/getty 38400 tty5' /etc/inittab
sed -i '/6:23:respawn:\/sbin\/getty/c #6:23:respawn:\/sbin\/getty 38400 tty6' /etc/inittab




########## REMOVIENDO SERVICIOS 
update-rc.d -f cron remove



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

## Ajuste resolucion pantalla
##sh -c 'xrandr --output Virtual-1 --mode 1280x768' &



########## ICEWM: AJUSTE PERMISOS APAGADO/REINICIO/SUSPENSION
mkdir -p /etc/sudoers.d/

echo "
ALL ALL=(ALL) NOPASSWD: /sbin/reboot
ALL ALL=(ALL) NOPASSWD: /sbin/poweroff
ALL ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend
" > /etc/sudoers.d/icewm
fi




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




update-grub
update-initramfs -u
sudo init q



