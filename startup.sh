#!/bin/bash

echo -e "\nBleachbit..."

bash ~/.config/autostart/bleachbit.sh

echo -e "\nAPT..."

sudo bash ~/.config/autostart/apt.sh

echo -e "\nExtensions..."

echo -e "\n* Extension Update..."

bash ~/.config/autostart/gnome-shell-extension-installer --update 1160 # Dash to Panel
bash ~/.config/autostart/gnome-shell-extension-installer --update 1228 # Arc Menu
bash ~/.config/autostart/gnome-shell-extension-installer --update 1031 # TopIcons Plus
bash ~/.config/autostart/gnome-shell-extension-installer --update 1011 # Dynamic Panel Transparency

echo -e "\n* Extension Enable..."

gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
gnome-shell-extension-tool -e arc-menu@linxgem33.com
gnome-shell-extension-tool -e TopIcons@phocean.net
gnome-shell-extension-tool -e dynamic-panel-transparency@rockon999.github.io

echo -e "\nAll Done."

sleep 3
