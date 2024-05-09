#!/bin/bash

echo "
###################################
      AJUSTES SIN DM
###################################
"


## Inicio automatico del WM despues del inicio de sesion 
echo '

########## CUSTOM ################
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
' >> ~/.profile


## Configuracion adicional ()
echo "

####### CUSTOM #####
dbus-update-activation-environment DISPLAY
" >> ~/.bashrc
