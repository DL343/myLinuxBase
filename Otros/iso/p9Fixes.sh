#!/usr/bin/env bash

apt update
apt -y upgrade


lpkg update
lpkg install sysvinit-3.11

	
##### UFW
sudo apt -y install ufw

##### UFW: ACTIVACION
sudo ufw enable

##### UFW: PREFIX
update-rc.d -f nftables remove

	
##### NFTABLES
update-rc.d -f nftables remove



##### GIT: ELIMINACION
apt -y purge git

##### BLEACHBIT LIVE
mkdir -p /home/live/.config/bleachbit/
echo '[bleachbit]
auto_hide = True
check_beta = False
check_online_updates = False
dark_mode = True
debug = False
delete_confirmation = True
exit_done = False
remember_geometry = True
shred = False
units_iec = False
window_fullscreen = False
window_maximized = False
first_start = False
version = 4.4.2
window_x = 240
window_y = 50
window_width = 800
window_height = 600
hashsalt = a6c74f64195676e1b401a30114687f2321292da05d0dada86a8d1619db61dfc51221d40601d6c115753511d6150259d98c208576f9815f58f825fe42b992e93d

[hashpath]

[list/shred_drives]
0 = /home/live/.cache

[preserve_languages]
en = True

[tree]
apt = True
apt.autoclean = True
apt.autoremove = True
apt.clean = True
apt.package_lists = True
bash = True
bash.history = True
deepscan.backup = True
deepscan.tmp = True
deepscan.thumbs_db = True
deepscan.vim_swap_root = True
deepscan.vim_swap_user = True
deepscan = True
deepscan.ds_store = True
system = True
system.desktop_entry = True
system.cache = True
system.clipboard = True
system.custom = True
system.recent_documents = True
system.rotated_logs = True
system.tmp = True
system.trash = True
thumbnails = True
thumbnails.cache = True
x11 = True
x11.debug_logs = True
' > /home/live/.config/bleachbit/bleachbit.ini

chown live:live -R /home/live/

