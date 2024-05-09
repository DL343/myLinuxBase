#!/bin/bash



#home="$HOME"

### Configuracion del servicio para systemd
#echo '                                                                                           
### Se indican las directivas
#[Unit]
### Descripcion del servicio
#Description=Servicio de una sola ejecucion para reducir el consumo para cargadores limitados a 5V 3A (15W)

### Controla el orden de ejecucion, "ejecutate despues de ..."
#After=network.target network-online.target


### Version ligera de "Requires". Systemd intentara arrancar las
###  unidades indicadas
#Wants=network-online.target


#[Service]
### Ruta del fichero/script a ejecutar               <-------------------------------------------------------------- INVESTIGAR COMO OBTENER RUTA DEL USUARIO GENERICA
#ExecStart=$home/.config/scripts/low_power.sh 


#[Install]
#WantedBy=multi-user.target


#' | sudo tee /etc/systemd/system/low_power.service



echo "
########################################################################
                    LOW POWER PREFIX - 5V 3A (15W)
########################################################################
"

## Creacion del directorio por si no existe
mkdir -p ~/.config/scripts/

## Configuracion del script
echo '#!/bin/bash

sudo cpufreq-set -c  0 -u 1.8GHz
sudo cpufreq-set -c  5 -u 1.8GHz
sudo cpufreq-set -c  7 -u 1.8GHz

sudo cpufreq-set -c  0 -g ondemand
sudo cpufreq-set -c  5 -g ondemand
sudo cpufreq-set -c  7 -g ondemand

' > ~/.config/scripts/low_power.sh


## Dando permiso de ejecucion al script
chmod +x ~/.config/scripts/low_power.sh


home=$HOME

## Configuracion del servicio para systemd
echo '                                                                                           
## Se indican las directivas
[Unit]
## Descripcion del servicio
Description=Servicio de una sola ejecucion para reducir el consumo para cargadores limitados a 5V 3A (15W)

## Controla el orden de ejecucion, "ejecutate despues de ..."
After=network.target network-online.target


## Version ligera de "Requires". Systemd intentara arrancar las
##  unidades indicadas
Wants=network-online.target


[Service]
## Ruta del fichero/script a ejecutar               <-------------------------------------------------------------- INVESTIGAR COMO OBTENER RUTA DEL USUARIO ACTUAL
ExecStart='$home'/.config/scripts/low_power.sh 


[Install]
WantedBy=multi-user.target


' | sudo tee /etc/systemd/system/low_power.service



## Habilitando el servicio en systemd
sudo systemctl enable low_power.service


: " POWER SUPER SAVE

sudo cpufreq-set -c  0 -u 1.2GHz
sudo cpufreq-set -c  5 -u 1.2GHz
sudo cpufreq-set -c  7 -u 1.2GHz

sudo cpufreq-set -c  0 -u 1.4GHz
sudo cpufreq-set -c  5 -u 1.4GHz
sudo cpufreq-set -c  7 -u 1.4GHz

sudo cpufreq-set -c  0 -u 1.8GHz
sudo cpufreq-set -c  5 -u 1.8GHz
sudo cpufreq-set -c  7 -u 1.8GHz

sudo cpufreq-set -c  0 -g ondemand
sudo cpufreq-set -c  5 -g ondemand
sudo cpufreq-set -c  7 -g ondemand


1.8Ghz = max 11.6 W 
1.2Ghz = max 7.6 W



"






