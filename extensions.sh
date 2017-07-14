#!/bin/bash

echo -e "\n* Updating extensions..."

bash ~/.config/autostart/gnome-shell-extension-installer --update 1160 # Dash to Panel
bash ~/.config/autostart/gnome-shell-extension-installer --update 1228 # Arc Menu
bash ~/.config/autostart/gnome-shell-extension-installer --update 1031 # TopIcons Plus
bash ~/.config/autostart/gnome-shell-extension-installer --update 1011 # Dynamic Panel Transparency
bash ~/.config/autostart/gnome-shell-extension-installer --update 118  # No Topleft Hot Corner

echo -e "\n* Enabling extensions..."

gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
gnome-shell-extension-tool -e arc-menu@linxgem33.com
gnome-shell-extension-tool -e TopIcons@phocean.net
gnome-shell-extension-tool -e dynamic-panel-transparency@rockon999.github.io
gnome-shell-extension-tool -e nohotcorner@azuri.free.fr
