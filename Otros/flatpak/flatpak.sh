#!/bin/bash


if [ "$isFlatpak" == "y" ] || [ "$isFlatpak" == "" ]; then
	echo "Comenzando instalacion..." 
	
	echo '########## INSTALACION FLATPAK ##########'
	sudo nala install flatpak -y

	## Añadir repo de flathub
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	## Reinicio necesario

	echo '########## APPS ##########'

	## Joplin
	flatpak install flathub -y net.cozic.joplin_desktop

	## Waterfox 
	flatpak install flathub -y net.waterfox.waterfox

	## VLC
	flatpak install flathub -y org.videolan.VLC

	## Audacius
	flatpak install flathub -y org.atheme.audacious

	## Pinta
	flatpak install flathub -y com.github.PintaProject.Pinta


	echo '########## EMPEREJAR TEMAS E ICONOS DEL SISTEMA CON FLATPAK ##########'
	### Dar permiso a la carpeta
	sudo flatpak override --filesystem=$HOME/.themes
	sudo flatpak override --filesystem=$HOME/.icons

	## Establecer ficheros a usar

	if [ -d "$HOME/.themes/" ]; then
		echo "Perfecto, existe la carpeta en $HOME/.themes"
	else
		echo "No existe la carpeta en $HOME/.themes, se procede a obtener los archivos..."
		cp -r /usr/share/themes/ $HOME/.themes
		echo "Listo"
	fi

	echo "Estableciendo configuracion..."
	sudo flatpak override --env=GTK_THEME=Adwaita-dark
	echo "Listo."


	if [ -d "$HOME/.icons/" ]; then
		echo "Perfecto, existe la carpeta en $HOME/.icons"
	else
		echo "No existe la carpeta en $HOME/.icons, se procede a obtener los archivos..."
		cp -r /usr/share/icons/ $HOME/.icons
		echo "Listo"
	fi

	echo "Estableciendo configuracion..."
	sudo flatpak override --env=ICON_THEME=Adwaita
	echo "Listo."

else

	echo "## Flatpak marcado para no instalar"
	
fi

