#!/bin/bash

cp ./.gtkrc-2.0   /home/live/
cp ./.gtkrc-2.0   /etc/skel/

cd ./.config.fake/
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/  akregatorrc  kactivitymanagerdrc  kcminputrc  kconf_updaterc  kded5rc  kdeglobals  kmixrc  krunnerrc  kscreenlockerrc  ksmserverrc    kwalletrc  kwinrc  kwinrulesrc  kxkbrc  plasma-localerc  plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc  powerdevilrc  powermanagementprofilesrc  /home/live/.config
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/  akregatorrc  kactivitymanagerdrc  kcminputrc  kconf_updaterc  kded5rc  kdeglobals  kmixrc  krunnerrc  kscreenlockerrc  ksmserverrc    kwalletrc  kwinrc  kwinrulesrc  kxkbrc  plasma-localerc  plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc  powerdevilrc  powermanagementprofilesrc  /etc/skel/.config


