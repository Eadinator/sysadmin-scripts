#!/bin/bash

DIR=/usr/local/bin

if [[ $EUID -eq 0 ]]; then
	echo "%sudo ALL=(root) NOPASSWD: $(which apt), $(which rm) /etc/sudoers.d/02-custom" > /etc/sudoers.d/02-custom
	chmod 440 /etc/sudoers.d/02-custom

	sudo -u $SUDO_USER $DIR/startup.sh
else
	echo '+ Updating packages...'
	sudo apt -qq update && sudo apt --purge --yes --verbose-versions full-upgrade
	echo

	echo '+ Removing old kernels...'
	dpkg -l | awk '{print $2}' | $DIR/filter_pkglist.pl $(uname -r) | xargs --no-run-if-empty sudo apt --yes purge
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

	sudo rm /etc/sudoers.d/02-custom

	echo '+ Finished +'
	sleep 3
fi
