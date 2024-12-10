#!/usr/bin/env bash

apt update
apt -y upgrade

sudo apt 

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

###### BLEACHBIT LIVE
#mkdir -p /home/live/.config/bleachbit/
#echo '[bleachbit]
#auto_hide = True
#check_beta = False
#check_online_updates = False
#dark_mode = True
#debug = False
#delete_confirmation = True
#exit_done = False
#remember_geometry = True
#shred = False
#units_iec = False
#window_fullscreen = False
#window_maximized = False
#first_start = False
#version = 4.4.2
#window_x = 240
#window_y = 50
#window_width = 800
#window_height = 600
#hashsalt = a6c74f64195676e1b401a30114687f2321292da05d0dada86a8d1619db61dfc51221d40601d6c115753511d6150259d98c208576f9815f58f825fe42b992e93d

#[hashpath]

#[list/shred_drives]
#0 = /home/live/.cache

#[preserve_languages]
#en = True

#[tree]
#apt = True
#apt.autoclean = True
#apt.autoremove = True
#apt.clean = True
#apt.package_lists = True
#bash = True
#bash.history = True
#deepscan.backup = True
#deepscan.tmp = True
#deepscan.thumbs_db = True
#deepscan.vim_swap_root = True
#deepscan.vim_swap_user = True
#deepscan = True
#deepscan.ds_store = True
#system = True
#system.desktop_entry = True
#system.cache = True
#system.clipboard = True
#system.custom = True
#system.recent_documents = True
#system.rotated_logs = True
#system.tmp = True
#system.trash = True
#thumbnails = True
#thumbnails.cache = True
#x11 = True
#x11.debug_logs = True
#' > /home/live/.config/bleachbit/bleachbit.ini

chown live:live -R /home/live/





lpkgbuild update
lpkgbuild install sysvinit-3.11


apt install -y linux-image-5.10.230-loc-os



echo "
############################################
####### PREFIX REFRACTA SNAPSHOT
############################################
"
function refractaSnapshot {

kernel=$(ls /boot/ | grep vmlinuz | grep -v old)
initrd=$(ls /boot/ | grep initrd | grep -v old)

kernelCount=$(ls /boot/ | grep initrd | grep -v somepattern | wc -l)
initrdCount=$(ls /boot/ | grep vmlinuz | grep -v somepattern | wc -l)

if !( [ "$kernelCount" -eq 1 ] && [ "$kernelCount" -eq 1 ] )
then

	echo "
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      Algo no cuadra, revisar kernel e initrd en /boot/
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    "

else

    
echo "::::: Perfecto, se detecto 
kernel = $kernel y initrm = $initrd
continuando con este paso...."


##### REFRACTASNAPSHOT: AJUSTE ENTRADAS BIOS KERNEL/VMLINUZ
awk -v kernel="$kernel" 'BEGIN { count = 0 }
{
   	if (/kernel \/live\/vmlinuz/){
			if (count < 3) {
				print "     kernel /live/" kernel
			}     
			if (count == 3) {
				print "     kernel /live/" kernel " noapic noapm nodma nomce nolapic nosmp forcepae nomodeset vga=normal ${ifnames_opt} ${netconfig_opt} ${username_opt}" 
			}
			count++	
    } else {
        print
    }
}' /usr/lib/refractasnapshot/iso/isolinux/live.cfg > /tmp/live.cfg.tmp
mv /tmp/live.cfg.tmp   /usr/lib/refractasnapshot/iso/isolinux/live.cfg


##### REFRACTASNAPSHOT: AJUSTE ENTRADAS BIOS INIT
awk -v initrd="$initrd" 'BEGIN { count = 0 }
{
   	if (/append initrd=\/live\/initrd.img/){
			if (count == 0) {
				print "    append initrd=/live/" initrd " boot=live ${ifnames_opt} ${netconfig_opt} ${username_opt}  "
			}     
			if (count == 1) {
				print "    append initrd=/live/" initrd " boot=live ${ifnames_opt} ${netconfig_opt} ${username_opt} locales=it_IT.UTF-8 keyboard-layouts=it"
			}  
			if (count == 2) {
				print "    append initrd=/live/" initrd " boot=live  toram ${ifnames_opt} ${netconfig_opt} ${username_opt} "
			}  
			if (count == 3) {
				print "    append initrd=/live/" initrd " boot=live   "
			} 
			count++	
    } else {
        print
    }
}' /usr/lib/refractasnapshot/iso/isolinux/live.cfg   >  /tmp/live.cfg.tmp
mv /tmp/live.cfg.tmp   /usr/lib/refractasnapshot/iso/isolinux/live.cfg



##### REFRACTASNAPSHOT: AJUSTE ARCHIVO DE CONFIGURACION: KERNEL
awk -v kernel="$kernel" -v initrd="$initrd" '
BEGIN { count = 0 }
{
	if (/kernel_image=/) {
		if( count == 1 ){
			print "kernel_image=\"/boot/" kernel "\""
		} else {
			count++
			print
		}	
	} else {
		print
	}
	
}' /etc/refractasnapshot.conf   >   /tmp/refractasnapshot.conf.tmp
mv /tmp/refractasnapshot.conf.tmp   /etc/refractasnapshot.conf 


##### REFRACTASNAPSHOT: AJUSTE ARCHIVO DE CONFIGURACION: INIT
awk -v kernel="$kernel" -v initrd="$initrd" '
BEGIN { count = 0 }
{
	if (/initrd_image=/) {
		print "initrd_image=\"/boot/" initrd "\""
	} else {
		print
	}
	
}' /etc/refractasnapshot.conf   >   /tmp/refractasnapshot.conf.tmp
mv /tmp/refractasnapshot.conf.tmp   /etc/refractasnapshot.conf 














##### REFRACTASNAPSHOT: AJUSTE ENTRADAS EFI KERNEL
awk -v kernel="$kernel" 'BEGIN { count = 0 }
{

	if(/linux   \/live\/vmlinuz/){
		if (count == 0) {
		print "    linux   /live/" kernel " boot=live ${ifnames_opt} ${netconfig_opt} ${username_opt}    "
		}    
		if (count == 1) {
		print "    linux   /live/" kernel " boot=live ${ifnames_opt} ${netconfig_opt} ${username_opt} locales=it_IT.UTF-8 keyboard-layouts=it "
		} 
		if (count == 2) {
		print " linux   /live/" kernel " boot=live toram ${ifnames_opt} ${netconfig_opt} ${username_opt}    "
		} 
		if (count == 3) {
		print " linux   /live/" kernel " boot=live nocomponents=xinit noapm noapic nolapic nodma nosmp forcepae nomodeset vga=normal ${ifnames_opt} ${netconfig_opt} ${username_opt} "
		}

		count++

	} else {

		print

	}
}

' /usr/lib/refractasnapshot/grub.cfg.template   >   /tmp/grub.cfg.template
mv  /tmp/grub.cfg.template   /usr/lib/refractasnapshot/grub.cfg.template







##### REFRACTASNAPSHOT: AJUSTE ENTRADAS EFI INIT
awk -v initrd="$initrd" '{

	if(/initrd  \/live\/initrd.img/){

		print "    initrd  /live/" initrd

	} else {

		print

	}
}
' /usr/lib/refractasnapshot/grub.cfg.template   >   /tmp/grub.cfg.template
mv  /tmp/grub.cfg.template   /usr/lib/refractasnapshot/grub.cfg.template



fi

}


refractaSnapshot


apt -y autoremove --purge
	
