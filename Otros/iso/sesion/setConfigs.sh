#!/bin/bash

rm -r ./skel/
rm -r ./live/


## .CONFIG`S ESPECIFICAS
BASE=./skel/
install -D $HOME/.gtkrc-2.0                                  $BASE/.gtkrc-2.0
install -D $HOME/.config/gtk-3.0/settings.ini                $BASE/.config/gtk-3.0/settings.ini 

install -D $HOME/.config/nitrogen/nitrogen.cfg               $BASE/.config/nitrogen/nitrogen.cfg
install -D $HOME/.config/nitrogen/bg-saved.cfg               $BASE/.config/nitrogen/bg-saved.cfg 
install -D $HOME/.config/volumeicon/volumeicon               $BASE/.config/volumeicon/volumeicon
install -D $HOME/.config/pcmanfm/default/pcmanfm.conf        $BASE/.config/pcmanfm/default/pcmanfm.conf
install -D $HOME/.config/flameshot/flameshot.ini             $BASE/.config/flameshot/flameshot.ini 

install -D $HOME/.face							             $BASE/.face 
install -D $HOME/.profile                                    $BASE/.profile
install -D $HOME/.xinitrc                                    $BASE/.xinitrc

cp -r $HOME/.icewm                                           $BASE/
cp -r $HOME/.config/scripts/                                 $BASE/.config/




#######################################################################################

BASE=./live/
install -D $HOME/.gtkrc-2.0                                  $BASE/.gtkrc-2.0
install -D $HOME/.config/gtk-3.0/settings.ini                $BASE/.config/gtk-3.0/settings.ini 

install -D $HOME/.config/nitrogen/nitrogen.cfg               $BASE/.config/nitrogen/nitrogen.cfg
install -D $HOME/.config/nitrogen/bg-saved.cfg               $BASE/.config/nitrogen/bg-saved.cfg 
install -D $HOME/.config/volumeicon/volumeicon               $BASE/.config/volumeicon/volumeicon
install -D $HOME/.config/pcmanfm/default/pcmanfm.conf        $BASE/.config/pcmanfm/default/pcmanfm.conf
install -D $HOME/.config/flameshot/flameshot.ini             $BASE/.config/flameshot/flameshot.ini 

install -D $HOME/.face							             $BASE/.face 
install -D $HOME/.profile                                    $BASE/.profile
install -D $HOME/.xinitrc                                    $BASE/.xinitrc

cp -r $HOME/.icewm                                           $BASE/
cp -r $HOME/.config/scripts/                                 $BASE/.config/
