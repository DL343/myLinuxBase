#!/usr/bin/env bash

#nombreDistro=Prueba001
 



if  grep -q 'vm.swappiness=' $HOME/tortuga
then
	echo "Texto encontrado, ajustando..."
	sudo sed -i '/vm.swappiness=/c vm.swappiness=10' $HOME/tortuga

else
	echo "Texto no encontrado, añadiendo..."
	echo "vm.swappiness=10" | sudo tee -a $HOME/tortuga > /dev/null
	
fi
