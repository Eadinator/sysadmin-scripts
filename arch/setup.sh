#!/bin/bash

# Run as non-root user, without sudo

sudo bash -c "printf '%s\n' '%wheel ALL=(ALL) ALL' '%wheel ALL=(root) NOPASSWD: /usr/local/bin/startup.sh' >> /etc/sudoers"

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

# Global Dark Theme - off
# GTK+ Theme - Arc-Maia
# Icons - Adwaita (default)
# Cursor - Breeze
# Shell theme - Arc-Maia-Dark

# Dash to panel - Panel size 32px, App icon margin 4px
