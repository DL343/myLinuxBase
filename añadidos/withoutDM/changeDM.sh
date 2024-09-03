#!/bin/bash


echo "
###################################
      CHANGE DISPLAY MANAGER
###################################
"



read -p "¿Que WM desea aplicar?: " WM

## Configuracion de startx
echo "$WM" > ~/.xinitrc
echo 'Listo


'



echo "Aplicando ajustes..." 

 
if grep -q '############## CUSTOM ##################' $HOME/.profile
then
	echo 'Existe este ajuste, omitiendo este paso...' 
else

	echo '
    ########################################
	############## CUSTOM ##################
    ######################################## 
	
	## Inicio automatico del WM despues del inicio de sesion 
	if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	  exec startx
	fi

	## Ajuste adicional
	dbus-update-activation-environment DISPLAY


	'  >> $HOME/.profile

fi

echo "
--------------
    LISTO
--------------
"
