#!/bin/bash

	#if [ command -v pulseaudio &>/dev/null ]; then                      #### PENDIENTE DE COMPROBAR SI FUNCIONA
		### PulseAudio detectado. Desinstalando...
		#systemctl --user --now disable pulseaudio.service pulseaudio.socket
	#else 
		#echo "No existe pulseaudio, continuando al siguiente paso..."
	#fi




### Contador a 1 segundo
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

### Wallpaper grub
#### Copiar...
sudo cp system/imgGrub/* /boot/grub/imgGrub.jpg

#### Configurar 
sudo sed -i '$a GRUB_BACKGROUND="/boot/grub/imgGrub.jpg"' /etc/default/grub


## Actualizar cambios a grub
sudo update-grub
