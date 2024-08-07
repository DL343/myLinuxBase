#!/bin/bash

if [ "$isQemuKVM" == "y" ] || [ "$isQemuKVM" == "" ]; then

	echo '############################## KVM ##############################'
	echo "Comprobando soporte para virtualizacion..."
	if [ "$egrep -c '(vmx|svm)' /proc/cpuinfo" > 0 ]; then
		echo "Perfecto, existe el soporte!"
		echo "Comenzando instalacion..."
		sudo apt install qemu-system-x86 virt-manager virtinst -y
		sudo apt install libvirt-clients bridge-utils libvirt-daemon-system -y
		sudo apt install dnsmasq qemu-utils ovmf -y
		
		echo "## Habilitar servicio"
		sudo systemctl enable --now libvirtd
		
		echo "## ¿¿¿¿Permitir usuario normal/comun usar kvm y libvirt???????"
		sudo usermod -aG kvm $USER
		sudo usermod -aG libvirt $USER
		
		echo "## Activa la red por defecto"
		sudo virsh net-start default

		echo "## Habilitar automaticamente la red por defecto"
		sudo virsh net-autostart default

	else
		echo "No hay soporte para virtualizacion"
		echo "Omitiendo esta instalacion."
	fi



fi


