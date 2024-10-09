#!/bin/bash



## .CONFIG`S ESPECIFICAS
BASE=./skel/
install -D $BASE/.gtkrc-2.0                                    $HOME/.gtkrc-2.0
install -D $BASE/.config/gtk-3.0/settings.ini                  $HOME/.config/gtk-3.0/settings.ini 

install -D $BASE/.config/nitrogen/nitrogen.cfg                 $HOME/.config/nitrogen/nitrogen.cfg
install -D $BASE/.config/nitrogen/bg-saved.cfg                 $HOME/.config/nitrogen/bg-saved.cfg 
install -D $BASE/.config/volumeicon/volumeicon                 $HOME/.config/volumeicon/volumeicon
install -D $BASE/.config/pcmanfm/default/pcmanfm.conf          $HOME/.config/pcmanfm/default/pcmanfm.conf
install -D $BASE/.config/pcmanfm/default/desktop-items-0.conf  $HOME/.config/pcmanfm/default/desktop-items-0.conf
install -D $BASE/.config/flameshot/flameshot.ini               $HOME/.config/flameshot/flameshot.ini 
install -D $BASE/.config/mimeapps.list                         $HOME/.config/mimeapps.list 
install -D $BASE/.config/htop/htoprc                           $HOME/.config/htop/htoprc
install -D $BASE/.config/bleachbit/bleachbit.ini               $HOME/.config/bleachbit/bleachbit.ini

cp -r $BASE/.icewm                                             $HOME/
cp -r $BASE/.config/scripts/                                   $HOME/.config/
cp -r $BASE/.config/rofi/                                      $HOME/.config/

