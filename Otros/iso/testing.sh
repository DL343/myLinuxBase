#!/usr/bin/env bash


source ./variables.sh

if [ "sysvinit" == "${init}" ]
then
	
	echo "sysVinit"

fi



if [ "systemd" == "${init}" ]
then

		echo "systemd"

fi

echo "#########################################"



	echo "
	########################################################################
	####################### MODULOS DEL KERNEL ############################# 
	########################################################################
	"
	## ***Todo esta comentado, al instalar paquetes piden regresar el archivo como estaba
	## Evita que ciertos módulos del kernel del microcodigo del procesador se carguen automáticamente
	## AMD 
	echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

' > /etc/modprobe.d/amd64-microcode-blacklist.conf


	## INTEL
	echo '# The microcode module attempts to apply a microcode update when
# it autoloads.  This is not always safe, so we block it by default.

## Debian default
blacklist microcode

' > /etc/modprobe.d/intel-microcode-blacklist.conf
		
	update-initramfs -u
		
		
	

