#!/usr/bin/env bash



function soloConfigs {



apt -y reinstall welcome-loc-os

##################################################
## BASE MINIMA
##################################################
apt -y install kde-plasma-desktop



##################################################
## Wallpapers, iconos y temas 
##################################################

mkdir -p /usr/share/color-schemes/
mkdir -p /usr/share/icons/

mkdir -p /tmp/FlatRemixYellow/ 
mkdir -p /tmp/Vimix/

tar -xzvf  ./custom/themes/kde/FlatRemixYellow.tar.gz   -C   /tmp/FlatRemixYellow
tar -xzvf  ./custom/themes/kde/Vimix.tar.gz             -C   /tmp/Vimix

cp -r  /tmp/FlatRemixYellow/*     /usr/share/color-schemes
cp -r  /tmp/Vimix/*               /usr/share/icons

rm -r  /tmp/FlatRemixYellow/ 
rm -r  /tmp/Vimix/




##################################################
## Skel
##################################################
#wget -O /tmp/defaults.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/defaults.tar.gz
#wget -O /tmp/live.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/live.tar.gz

rm -r   /home/live/
rm -r   /etc/skel/

cp -r   ./sesion/kdeConfig/testing/live/   /home/
cp -r   ./sesion/kdeConfig/testing/live/   /etc/skel/


#cd ./sesion/kdeConfig/
#./setKDEConfig.sh
#cd ..
#cd ..





##################################################
##  SDDM
##################################################
echo "[Autologin]
User=live
Session=plasma" > /etc/sddm.conf




##################################################
## Autostarts
##################################################
mkdir -p /etc/xdg/autostart.disabled
mv /etc/xdg/autostart/at-spi-dbus-bus.desktop           /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/klipper.desktop                   /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/xembedsniproxy.desktop            /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/baloo_file.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/pam_kwallet_init.desktop          /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/geoclue-demo-agent.desktop        /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/gmenudbusmenuproxy.desktop        /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/kaccess.desktop                   /etc/xdg/autostart.disabled/
#######################mv /etc/xdg/autostart/powerdevil.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/kup-daemon.desktop                /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/org.kde.discover.notifier.desktop /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/org.kde.kdeconnect.daemon.desktop /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/konqy_preload.desktop             /etc/xdg/autostart.disabled/
mv /etc/xdg/autostart/print-applet.desktop              /etc/xdg/autostart.disabled/



##################################################
## Desactivar servicios de plasma
##################################################
apt -y remove kdeconnect

#chmod -x /usr/lib/x86_64-linux-gnu/libexec/kactivitymanagerd
#######################chmod -x /usr/bin/kglobalaccel5
#######################chmod -x /usr/bin/kded5


##################################################
## Desactiva plasmoides
##################################################


mkdir /usr/share/plasma/plasmoids.disabled
mv /usr/share/plasma/plasmoids/* /usr/share/plasma/plasmoids.disabled/
mv /usr/share/plasma/plasmoids.disabled/org.kde.desktopcontainment        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.kscreen                   /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.panel                     /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.volume             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.systemtray         /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.windowlist         /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.showdesktop        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.private.systemtray /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.panelspacer        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.notifications      /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.lock_logout        /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.kicker             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.kickoff            /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.icontasks          /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.icon               /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.digitalclock       /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.milou                     /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.appmenu            /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.calendar           /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.folder             /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.marginsseparator   /usr/share/plasma/plasmoids/   
mv /usr/share/plasma/plasmoids.disabled/org.kde.plasma.taskmanager        /usr/share/plasma/plasmoids/



mkdir -p /home/live/.config/autostart
echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=Welcome
Comment=
Exec=/bin/loc-oswelcome.sh
OnlyShowIn=KDE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false
" > /home/live/.config/autostart/Welcome.desktop
chmod +x /home/live/.config/autostart/Welcome.desktop
chown live:live -R /home/live/


if grep -q "CUSTOM KDE" /usr/lib/refractasnapshot/snapshot_exclude.list
then
	echo ":::::'CUSTOM KDE' existe, omitiendo este paso....."
else
echo "####### CUSTOM KDE ########
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

sed -i '/mksq_opt="-comp xz -Xbcj x86"/c mksq_opt="-comp xz -Xbcj x86"' /etc/refractasnapshot.conf




cat << 'EOF' > /bin/loc-oswelcome.sh
#!/usr/bin/env bash
#=======================HEADER========================================|
#AUTOR
# Nicolas Longardi 'Locos por Linux' <nico@locosporlinux.com>
# Jefferson 'Slackjeff' Rocha <root@slackjeff.com.br>
# Creado totalmente en bash + YAD.
#===================================| VARIABLES
# Nombre del programa
PRG='Loc-OS Welcome'

# Version
VERSION='1.0'

# Archivo temporário para exclusion
temp="/etc/xdg/autostart/loc-oswelcome.desktop"

# Ubicacion de los iconos
icon='/usr/share/pixmaps/loc-oswelcome'

#===================================| INICIO
# Menu Principal
 yad --title="$PRG"            \
    --width="800"              \
    --height="450"             \
    --text-align=left          \
    --center                   \
    --image-on-top             \
    --undecorated              \
    --fontname="monospace 56"  \
    --image="${icon}/logo.png" \
    --borders=10               \
    --text="
<big><b>Loc-OS</b> Welcome</big>

Welcome, below you can check some options to install or configure the system.
Remember that the password of the <big><b>live</b></big> user is <big><b>live</b></big> and that of <big><b>root</b></big> is <big><b>root</b></big>."   \
   --form  --columns 4                                                                                     \
    --field="<b>Install</b>!${icon}/install.png!Install Loc-OS Linux on the HDD/SSD":BTN "/usr/bin/install-loc-os " \
    --field="<b>Website</b>!${icon}/site.png!Official site of Loc-OS":BTN "xdg-open https://loc-os.sourceforge.io/"           \
    --field="<b>LPKG</b>!${icon}/lpkg.png!Loc-OS Package Manager":BTN "/opt/Loc-OS-LPKG/.sudo/sudogui /opt/Loc-OS-LPKG/LpkgGui"   \ "
yad --width='500'
     --height='100'
     --center
     --undecorated
     --image="${icon}/sobreyad.png"
     --borders=5
     --text-align=left
     --text='

<big><b>$PRG</b></big>

Loc-OS Linux is a free GNU/Linux distribution, oriented to low resource consumption. Free from systemd and based on Debian stable.

<b>Version:</b> $VERSION
<b>License:</b> GPLv3
<b>Contact:</b> nico@locosporlinux.com'
     --button="Exit":1
"                                                                                                           \ "
"                                                                                                       \
    --field="<b>About</b>!${icon}/sobre.png!About this proyect":BTN  "xdg-open ${sites[4]}"            \
    --button="Exit":1

# El inicio automatico debe ser apenas en el primer boot.
# Luego debe ser excluido.
if [[ -e "$temp" ]]; then
    rm "$temp"
fi

EOF




##################################################
## SDDM
##################################################


##### SDDM: APLICANDO IMAGEN PERFIL USUARIO
cp  ./custom/dm/face.png   /home/live/.face.icon  
cp  ./custom/dm/face.png   /etc/skel/.face.icon 



#### SDDM: WALLPAPER CUSTOM
echo "
[General]
background=/usr/share/wallpapers/loquitux_playa.png
" > /usr/share/sddm/themes/breeze/theme.conf.user








#cp ./sesion/skel/.profile       /etc/skel/
#cp ./sesion/skel/.bash_logout   /etc/skel/
#cp ./sesion/skel/.bashrc        /etc/skel/


#cp ./sesion/skel/.profile       /home/live/
#cp ./sesion/skel/.bash_logout   /home/live/
#cp ./sesion/skel/.bashrc        /home/live/



rm -r /usr/share/wallpapers/SpaceFun.svg
rm -r /usr/share/wallpapers/SoftWaves.svg
rm -r /usr/share/wallpapers/moonlight.svg
rm -r /usr/share/wallpapers/Lines.svg
rm -r /usr/share/wallpapers/JoyInksplat.svg
rm -r /usr/share/wallpapers/homeworld.svg
rm -r /usr/share/wallpapers/default.png
	


##### XDG-USER-DIRS-UPDATE
echo '[Desktop Entry]
Type=Application
Name=User folders update
TryExec=
Exec=sh -c "xdg-user-dirs-update --force"
StartupNotify=false
NoDisplay=true

X-GNOME-Autostart-Phase=Initialization
X-KDE-autostart-phase=1
	
' > /etc/xdg/autostart/xdg-user-dirs.desktop


	


##### WALLPAPERS DEBIAN: LIMPIEZA
cd /usr/share/desktop-base/
rm -r homeworld-theme \
lines-theme \
spacefun-theme \
emerald-theme \
joy-inksplat-theme \
moonlight-theme \
futureprototype-theme \
joy-theme \
softwaves-theme \
kde_montain_1920x1080.png \
kde_montain_5120x2880.png \
kde_montainDark_1920x1080.png \
kde_mountainDark_5120x2880.png \
landscape_2560x1440.jpeg \	


#rm /etc/sddm.conf.d/kde_settings.conf

}















function apps {



###########################################################
## COMPLEMENTOS
############################################################

##### APPS
apt -y install librewolf kde-spectacle mpv kamera kate ark kcalc gwenview fastfetch okular unrar-free unzip webapp-manager zip libreoffice-calc libreoffice-writer htop imagemagick cmst






##################################################
## Elimina residuos
##################################################

apt -y purge apparmor aspell-es bup chafa cups-pk-helper debian-reference-es debian-reference-common fonts-freefont-ttf fonts-liberation ispanish kdeconnect konqueror kpeople-vcard kup-backup kwrite manpages-es mlocate par2 partitionmanager plasma-browser-integration plasma-disks plocate python3-cairo python3-cups python3-cupshelpers python3-fuse python3-pylibacl python3-smbc python3-tornado rtkit smartmontools sshfs system-config-printer vim-tiny zutty libreoffice-math

##### NETWORK
apt -y purge network-manager xterm


apt -y autoremove

#rm /home/live/Desktop/install.desktop






chown -R live:live /home/live/

	
	
}








read -p "
	1. Solo configuracion
	2. Configuracion + apps
	" seleccion


if [ "$seleccion" -eq "1" ]
then

soloConfigs

else

soloConfigs
apps

fi





















