#!/usr/bin/env bash


############################################################
################## SELECCION VARIABLES #################### 
############################################################
## Seleccion del nombre de la distro
read -p "
Seleciona el nombre de la distro:
" nombreDistro

echo "::---------------------"

## Seleccion del init
while true
do

	read -p "
	Selecciona el numero de acuerdo al init deseado:
	1 - sysvinit 
	2 - systemd
	" isInit

	case $isInit in
	1)
		init="sysvinit"
		echo "
		#!/usr/bin/env bash
		init=\"${init}\"
		nombreDistro=\"${nombreDistro}\"
		" > ./variables.sh
		break
		;;
		
	2)
		init="systemd"
		echo "
		#!/usr/bin/env bash
		init=\"${init}\"
		nombreDistro=\"${nombreDistro}\"
		" > ./variables.sh
		break
		;;

	*) 
		echo "::!!! Valor invalido, intentalo nuevamente"
		continue
		;;

	esac
	
done


echo "
:: Listo"
