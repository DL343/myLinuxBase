#!/usr/bin/env bash

source ./variables.sh



echo "
########################################################################
########################### AJUSTE SIN DM ##############################
########################################################################
"
##### GENERACION .XINITRC
echo "dbus-run-session -- icewm-session" > /etc/skel/.xinitrc


##### SE AÑADE AJUSTE DE .PROFILE
if grep -q "CUSTOM" /etc/skel/.profile
then
	echo "::::: Existe 'AJUSTE DE .PROFILE', omitiendo este paso..."
else
echo '
#---------------------------------------------
#------------------- CUSTOM ------------------
#---------------------------------------------

## Inicio automatico del WM despues del inicio de sesion 
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
'  >> /etc/skel/.profile
fi

echo "
########################################################################
########################## AJUSTE CALAMARES ############################
########################################################################
"

##### DEPENDENCIA
apt -y install seatd

##### CONSERVAR CHROMIUM
echo "
#!/bin/bash

echo \"backend: apt

operations:
  - remove:
      - 'live-boot'
      - 'live-boot-doc'
      - 'live-config'
      - 'live-config-doc'
      - 'live-tools'
      - 'live-boot-initramfs-tools'
      - 'live-config-sysvinit'
      - 'lxdm-loc-os'
      - 'lxdm'
      - 'calamares'
      - 'calamares-settings-loc-os'
      - 'welcome-loc-os'
      - 'waterfox'\" > /etc/calamares/modules/packages.conf
pkill yad
/usr/bin/install-loc-os
exit 0

" > /opt/browsers/scripts/chromium.sh

##### CONSERVAR WATERFOX
echo "
#!/bin/bash

echo \"backend: apt

operations:
  - remove:
      - 'live-boot'
      - 'live-boot-doc'
      - 'live-config'
      - 'live-config-doc'
      - 'live-tools'
      - 'live-boot-initramfs-tools'
      - 'live-config-sysvinit'
      - 'lxdm-loc-os'
      - 'lxdm'
      - 'calamares'
      - 'calamares-settings-loc-os'
      - 'welcome-loc-os'
      - 'chromium'
      - 'chromium-l10n'\" > /etc/calamares/modules/packages.conf
pkill yad
/usr/bin/install-loc-os
exit 0

" > /opt/browsers/scripts/firefox.sh


echo "
########################################################################
########################### AJUSTE ICEWM ##############################
########################################################################
"

##### STARTUP
if grep -q "dbus-update-activation-environment DISPLAY &" /etc/skel/.icewm/startup
then
	echo "::::: Existe 'dbus-update-activation-environment DISPLAY &', omitiendo este paso..."
else
echo "
## Ajuste sin DM
dbus-update-activation-environment DISPLAY &
" >> /etc/skel/.icewm/startup
fi





echo "
########################################################################
############################### TTY'S ##################################
########################################################################
"
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





update-rc.d cron remove
