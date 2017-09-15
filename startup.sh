#!/bin/bash

DIR=~/.config/autostart

echo '+ Performing bleachbit clean...'
bleachbit --list-cleaners | egrep '^(google_chrome|firefox)' | xargs --no-run-if-empty bleachbit --clean >/dev/null
echo

echo '+ Updating packages...'
sudo apt -qq update && sudo apt --purge --yes --verbose-versions full-upgrade
echo

echo '+ Removing old kernels...'
dpkg -l | awk '{print $2}' | $DIR/filter_pkglist.pl $(uname -r) | xargs --no-run-if-empty sudo apt --yes purge
echo

echo '+ Updating extensions...'
$DIR/gnome-shell-extension-installer --update 1160 # Dash to Panel
$DIR/gnome-shell-extension-installer --update 1228 # Arc Menu
$DIR/gnome-shell-extension-installer --update 118  # No Topleft Hot Corner
$DIR/gnome-shell-extension-installer --update 1031 # TopIcons Plus
echo

echo '+ Enabling extensions...'
gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
gnome-shell-extension-tool -e arc-menu@linxgem33.com
gnome-shell-extension-tool -e nohotcorner@azuri.free.fr
gnome-shell-extension-tool -e TopIcons@phocean.net
