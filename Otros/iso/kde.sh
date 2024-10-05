#!/usr/bin/env bash

##################################################
## Instalar KDE Plasma (base minima)
##################################################
apt -y install kde-plasma-desktop



##################################################
## Wallpapers y Temas visuales
##################################################
wget -O /tmp/loquitux.tar.gz https://staging.karlaperezyt.com/locoskde/src/wallpapers/loquitux.tar.gz
wget -O /tmp/colors.tar.gz https://staging.karlaperezyt.com/locoskde/src/themes/FlatRemixYellow.tar.gz
wget -O /tmp/icons.tar.gz https://staging.karlaperezyt.com/locoskde/src/themes/Vimix.tar.gz

mkdir -p /usr/share/wallpapers
mkdir -p /usr/share/color-schemes
mkdir -p /usr/share/icons

tar -xf /tmp/loquitux.tar.gz -C /usr/share/wallpapers
tar -xf /tmp/colors.tar.gz -C /usr/share/color-schemes
tar -xf /tmp/icons.tar.gz -C /usr/share/icons

rm /tmp/loquitux.tar.gz
rm /tmp/colors.tar.gz
rm /tmp/icons.tar.gz

##################################################
## Skel
##################################################
wget -O /tmp/defaults.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/defaults.tar.gz
wget -O /tmp/live.tar.gz https://staging.karlaperezyt.com/locoskde/src/userconfig/live.tar.gz
wget -O /tmp/face.png https://staging.karlaperezyt.com/locoskde/src/userconfig/face.png

mkdir -p /etc/skel

tar -xf /tmp/defaults.tar.gz -C /etc/skel
tar -xf /tmp/live.tar.gz -C /home/live
cp /tmp/face.png /etc/skel/.face

rm /tmp/defaults.tar.gz
rm /tmp/face.png

chown live /home/live -R

##################################################
## Elimina paquetes adicionales
##################################################

apt -y purge apparmor aspell-es bup chafa cups-pk-helper debian-reference-es debian-reference-common fonts-freefont-ttf fonts-liberation git ispanish kdeconnect konqueror kpeople-vcard kup-backup kwrite manpages-es mlocate par2 partitionmanager plasma-browser-integration plasma-disks plocate python3-cairo python3-cups python3-cupshelpers python3-fuse python3-pylibacl python3-smbc python3-tornado rtkit smartmontools sshfs system-config-printer vim-tiny zutty

apt autoremove


##################################################
## Hostname & SDDM
##################################################
echo "[Autologin]
User=live
Session=plasma" > /etc/sddm.conf

echo "Loc-OS" > /etc/hostname



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
mv /etc/xdg/autostart/powerdevil.desktop                /etc/xdg/autostart.disabled/
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
chmod -x /usr/bin/kglobalaccel5
chmod -x /usr/bin/kded5


##################################################
## Desactivar servicios de plasma
##################################################
apt -y remove kdeconnect

#chmod -x /usr/lib/x86_64-linux-gnu/libexec/kactivitymanagerd
chmod -x /usr/bin/kglobalaccel5
chmod -x /usr/bin/kded5

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
