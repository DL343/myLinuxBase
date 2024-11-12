#!/bin/bash

cd ./release/
cp ./.gtkrc-2.0   /etc/skel/
cp ./.gtkrc-2.0   /home/live/

cd ./.config/
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/  akregatorrc  kactivitymanagerdrc  kcminputrc  kconf_updaterc  kded5rc  kdeglobals  kmixrc  krunnerrc  kscreenlockerrc  ksmserverrc    kwalletrc  kwinrc  kwinrulesrc  kxkbrc  plasma-localerc  plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc  powerdevilrc  powermanagementprofilesrc  /home/live/.config
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/  akregatorrc  kactivitymanagerdrc  kcminputrc  kconf_updaterc  kded5rc  kdeglobals  kmixrc  krunnerrc  kscreenlockerrc  ksmserverrc    kwalletrc  kwinrc  kwinrulesrc  kxkbrc  plasma-localerc  plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc  powerdevilrc  powermanagementprofilesrc  /etc/skel/.config


