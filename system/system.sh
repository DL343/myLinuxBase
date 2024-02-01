#!/bin/bash

echo '########################## APPS BASICAS #########################'
## Actualizacion repositorios
sudo apt update 

## BASE
sudo apt install nala -y
sudo nala upgrade -y

sudo nala install xorg -y

sudo nala install htop neofetch gparted tlp git ufw xdg-user-dirs -y
sudo nala install lm-sensors nano inxi bash-completion -y

sudo nala install p7zip-full arandr gvfs network-manager-gnome -y
sudo nala install brightnessctl acpi lightdm lightdm-gtk-greeter -y
                                       
sudo nala install lxappearance arandr sakura thunar -y


#                 Lanzador           Filtro          EditorTxt       Screenshot
sudo nala install rofi               redshift        geany           gnome-screenshot         -y

#                 Calculadora        Portapapeles    WM              Limpiador
sudo nala install qalculate-gtk      parcellite      icewm           bleachbit                 -y



## OPCIONALES
sudo nala install   android-file-transfer  -y





echo "################################ UFW ##############################" 
## Activacion ufw
sudo ufw enable 




echo "############################## TLP ################################" 
## Activacion
sudo tlp start 

## Conf en modo bateria
sudo tlp bat




echo "############################## THUNAR ################################" 
## Establecer terminal por defecto
mkdir -p $HOME/.config/xfce4/

echo "TerminalEmulator=sakura" >> $HOME/.config/xfce4/helpers.rc






echo '################### CONFIGURACION DE LIBINPUT #####################'

if [ "$(sed -n '/Option "Tapping" "true"/p' /usr/share/X11/xorg.conf.d/40-libinput.conf)" == 'Option "Tapping" "true"' ]; then 

	echo "Perfecto!, existe la configracion, omitiendo este paso...";

else 

   echo "No existe la configuracion, aplicando...."
   sudo sed -i '/Identifier "libinput touchpad catchall"/a Option "Tapping" "true"' /usr/share/X11/xorg.conf.d/40-libinput.conf

   echo "Listo"
fi




#echo '##################### CONFIGURACION DE POLKIT ######################'
#sudo nala install policykit-1-gnome
#echo "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &" >> $HOME/.icewm/startup  




echo '########### GENERACION DE CARPETAS DE USUARIO BASICAS #############'
xdg-user-dirs-update 





echo '####################### AUDIO #########################'


# 1. INSTALACION DE LA BASE (ALSA)  
sudo nala install alsa-oss alsa-tools alsa-utils -y



if [ "$isPipeWire" == "y" ] || [ "$isPipeWire" == "" ]; then

## 2. SERVIDOR DE AUDIO
### PIPEWIRE
## // Paso 1.  Instalacion
sudo nala install pipewire-audio wireplumber pipewire-pulse pipewire-alsa libspa-0.2-bluetooth pavucontrol -y

## // Paso 2.  Configuracion
systemctl --user --now enable pipewire pipewire-pulse  
systemctl --user --now enable wireplumber.service


fi


## Configuracion volumen
amixer sset Master 99%




echo '########################### APARIENCIA ###########################'
mkdir -p $HOME/.config/gtk-3.0/

echo "[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=URW Gothic 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
" > $HOME/.config/gtk-3.0/settings.ini








echo '################### CONFIGURACION DE GRUB ########################'
### Contador a 1 segundo
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

### Guardar la ultima particion seleccionada
sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub
sudo sed -i '/GRUB_DEFAULT=saved/a GRUB_SAVEDEFAULT=true' /etc/default/grub

## Actualizar cambios a grub
sudo update-grub

