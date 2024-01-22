#!/bin/bash

echo '########## INSTALACION FLATPAK ##########'
sudo apt install flatpak

## Añadir repo de flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

## Reinicio necesario



echo '########## APPS ##########'

## Joplin
flatpak install flathub -y net.cozic.joplin_desktop

## Waterfox 
flatpak install flathub -y net.waterfox.waterfox

## VLC
flatpak install flathub -y org.videolan.VLC

## Geany
flatpak install flathub -y org.geany.Geany

## gThumb
flatpak install flathub -y org.gnome.gThumb

## Bleachbit
flatpak install flathub -y org.bleachbit.BleachBit


