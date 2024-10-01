#!/usr/bin/env bash

## OBLIGATORIOS
numVersion="0.1"

## Opcionales
## Entre parentesis  // codeName='(sparky)'
codeName=""
productUrl=""
supportUrl=""
knownIssuesUrl=""
releaseNotesUrl=""
donateUrl=""

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
	1 - sysVinit 
	2 - systemd
	" isInit

	case $isInit in
	1)
		init="sysvinit"
		break
		;;
		
	2)
		init="systemd"
		break
		;;

	*) 
		echo "::!!! Valor invalido, intentalo nuevamente"
		continue
		;;

	esac
	
done

while true
do

read -p "
Habilitar personalizacion? 
1 - Si
2 - No
" isPersonalize
	case $isPersonalize in

		1)
		custom="y" 
		break
		;;
		
		2)
		custom="n"
		break
		;;
		*)
		echo "::!!! Valor invalido, intentalo nuevamente"
		continue
		;;
	esac

done

echo "
#!/usr/bin/env bash
init=\"${init}\"
nombreDistro=\"${nombreDistro}\"
custom=\"${custom}\" 






## OBLIGATORIOS
numVersion=\"${numVersion}\"


# -----------------------------------------

## Opcionales
codeName=\"${codeName}\"
productUrl=\"${productUrl}\"
supportUrl=\"${supportUrl}\"
knownIssuesUrl=\"${knownIssuesUrl}\"
releaseNotesUrl=\"${releaseNotesUrl}\"
donateUrl=\"${donateUrl}\"

" > variables.sh


echo "
:: Listo"
