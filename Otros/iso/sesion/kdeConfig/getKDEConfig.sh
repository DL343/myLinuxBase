#!/bin/bash

cp ./.gtkrc-2.0   /home/live/
cp ./.gtkrc-2.0   /etc/skel/

cd ./.config.fake/
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/ gtkrc gtkrc-2.0 kactivitymanagerd-pluginsrc kactivitymanagerdrc kded5rc kdeglobals krunnerrc ksmserverrc kwalletrc kwinrc plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc /home/live/.config
cp -r gtk-3.0/ gtk-4.0/ kdedefaults/ gtkrc gtkrc-2.0 kactivitymanagerd-pluginsrc kactivitymanagerdrc kded5rc kdeglobals krunnerrc ksmserverrc kwalletrc kwinrc plasma-org.kde.plasma.desktop-appletsrc  plasmashellrc /etc/skel/.config

