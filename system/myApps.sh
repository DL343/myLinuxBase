#!/bin/bash

echo '############################## KVM ##############################'

echo "Comprobando soporte para virtualizacion..."

if [ "$egrep -c '(vmx|svm)' /proc/cpuinfo" > 0 ]; then
	echo "Perfecto, existe el soporte!"
	echo "Comenzando instalacion..."
	sudo nala install qemu-system-x86 virt-manager virtinst 
	sudo nala install libvirt-clients bridge-utils libvirt-daemon-system 
	sudo nala install dnsmasq qemu-utils ovmf
	
	## Habilitar servicio
	sudo systemctl enable --now libvirtd
	
	## Permitir usuario normal usar kvm y libvirt???????
	sudo usermod -aG kvm $USER
	sudo usermod -aG libvirt $USER
	
	## Activa la red por defecto
	sudo virsh net-start default

	## Habilitar automaticamente la red por defecto
	sudo virsh net-autostart default

else
	echo "No hay soporte para virtualizacion"
	echo "Omitiendo instalacion."
fi





