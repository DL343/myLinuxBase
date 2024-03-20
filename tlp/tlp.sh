#!/bin/bash

function TlpPowerSave(){

if [ "$isPowerSave" == "y" ] || [ "$isPowerSave" == "Y" ] ||  [ "$isPowerSave" == "" ]; then
	echo "## Configurando modo ahorro de energia..."
	
    cp /tlp/powerSaveTLP /etc/tlp.conf 

	echo "## Modo ahorro de energia aplicando correctamente"
		
else 
	echo "## TLP se instalara con la configuracion predeterminada"	
fi

}


if [ "$isTlp" == "y" ] || [ "$isTlp" == "Y" ] ||  [ "$isTlp" == "" ]; then
	
	## Activacion
	sudo tlp start 
	TlpPowerSave

else
 
	echo "TLP marcado para no instalar..."

fi


