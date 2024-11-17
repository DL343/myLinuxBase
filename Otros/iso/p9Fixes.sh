#!/usr/bin/env bash

apt update
apt -y upgrade

##### WALLPAPERS DEBIAN: LIMPIEZA
cd /usr/share/desktop-base/
rm -r homeworld-theme \
lines-theme \
spacefun-theme \
emerald-theme \
joy-inksplat-theme \
moonlight-theme \
futureprototype-theme \
joy-theme \
softwaves-theme \
kde_montain_1920x1080.png \
kde_montain_5120x2880.png \
kde_montainDark_1920x1080.png \
kde_mountainDark_5120x2880.png \
landscape_2560x1440.jpeg \	
	
##### UFW
sudo apt -y install ufw

##### UFW: ACTIVACION
sudo ufw enable

##### UFW: PREFIX
update-rc.d -f nftables remove

	
##### NFTABLES
update-rc.d -f nftables remove





chown live:live -R /home/live/

