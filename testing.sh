#!/bin/bash

read -p "mount/unmount qemu:
" opcion

case $opcion in

	mount)
		sudo modprobe nbd
		
		## Conectar imagen
		sudo qemu-nbd -c /dev/nbd0 /var/lib/libvirt/images/debian12_Minimal.qcow2
		
		## Montaje
		mkdir -p $HOME/Documentos/Punto\ de\ Encuentro/
		sudo mount /dev/nbd0p2 /home/oso/Documentos/Punto\ de\ Encuentro/
	;;

	unmount)		
		## Desmontaje
		sudo umount /home/oso/Documentos/Punto\ de\ Encuentro/
		
		## Desconexion
		sudo qemu-nbd -d /dev/nbd0
	;;

	*)


	;;

esac

