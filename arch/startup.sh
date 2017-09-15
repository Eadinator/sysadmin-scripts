#!/bin/bash

DIR=~/.config/autostart

echo '+ Updating packages...'
pacaur --noconfirm -Syu
echo

echo '+ Installing latest kernel...'
$DIR/kernels_to_install.pl | xargs --no-run-if-empty sudo pacman --noconfirm --needed -S
echo

echo '+ Removing old kernels...'
$DIR/kernels_to_remove.pl | xargs --no-run-if-empty sudo pacman --noconfirm -R
echo

echo '+ Updating extensions...'
gnome-shell-extension-installer --update 1160 # Dash to Panel
gnome-shell-extension-installer --update 1228 # Arc Menu
gnome-shell-extension-installer --update 118  # No Topleft Hot Corner
gnome-shell-extension-installer --update 1031 # TopIcons Plus
echo

echo '+ Enabling extensions...'
gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
gnome-shell-extension-tool -e arc-menu@linxgem33.com
gnome-shell-extension-tool -e nohotcorner@azuri.free.fr
gnome-shell-extension-tool -e TopIcons@phocean.net
echo

echo '+ Finished +'
sleep 3
