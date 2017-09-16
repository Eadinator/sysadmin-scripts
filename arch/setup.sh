#!/bin/bash

# Run as non-root user, without sudo

sudo bash -c "rm /etc/sudoers.d/*"

sudo bash -c "printf '%s\n' '%wheel ALL=(ALL) ALL' '%wheel ALL=(root) NOPASSWD: /usr/local/bin/startup.sh' > /etc/sudoers.d/01-custom"

sudo passwd -dl root

sudo sed -i.bak '/WaylandEnable/c\WaylandEnable=true' /etc/gdm/custom.conf
sudo sed -i.bak '/VerbosePkgLists/c\VerbosePkgLists' /etc/pacman.conf

sudo pacman -Syu --needed pacaur

pacaur -S --needed \
vim

# Deps for building AUR packages
pacaur -S --needed base-devel

pacaur -S --needed \
gnome-shell-extension-installer \
vi-vim-symlink \
epson-inkjet-printer-201207w

pacaur -Qq gnome-shell-extension-manjaro-update pamac | xargs --no-run-if-empty pacaur -R

GITHUB_URL=https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master
AUTOSTART=~/.config/autostart
BIN=/usr/local/bin

FILE=startup.desktop
REMOTE=$GITHUB_URL/$FILE
LOCAL=$AUTOSTART/$FILE

sudo wget --no-verbose -O $LOCAL $REMOTE
sudo chown root:root $LOCAL
sudo chmod 444 $LOCAL

SCRIPTS=(
arch/startup.sh
arch/kernels_to_install.pl
arch/kernels_to_remove.pl
)

for SCRIPT in ${SCRIPTS[@]}; do
	REMOTE=$GITHUB_URL/$SCRIPT
	LOCAL=$BIN/$(basename $SCRIPT)

	sudo wget --no-verbose -O $LOCAL $REMOTE
	sudo chown root:root $LOCAL
	sudo chmod 555 $LOCAL
done

# Global Dark Theme - off
# GTK+ Theme - Arc-Maia
# Icons - Adwaita (default)
# Cursor - Breeze
# Shell theme - Arc-Maia-Dark

# Dash to panel - Panel size 32px, App icon margin 4px
