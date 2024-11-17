#!/usr/bin/env bash

apt update
apt -y upgrade

	
	
##### UFW
sudo apt -y install ufw

##### UFW: ACTIVACION
sudo ufw enable

##### UFW: PREFIX
update-rc.d -f nftables remove

	
##### NFTABLES
update-rc.d -f nftables remove



##### GIT: ELIMINACION
git


chown live:live -R /home/live/

