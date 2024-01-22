#!/bin/bash

echo '########## ¿¿DEBLOAT?? ##########'

sudo systemctl disable bluetooth.service 

sudo systemctl disable avahi-daemon.service 

sudo systemctl disable cron.service 

sudo systemctl disable anacron.service

sudo systemctl disable ModemManager.service 
