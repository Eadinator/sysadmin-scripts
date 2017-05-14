#!/bin/bash

set -e

AUTOSTART_DIR=~/.config/autostart
GITHUB_URL="https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master"

sudo apt update

sudo apt install eterm gdebi-core curl
sudo apt purge xul-ext-ubufox

wget -O /tmp/bleachbit.deb https://download.bleachbit.org/bleachbit_1.12_all_ubuntu1604.deb
sudo gdebi /tmp/bleachbit.deb

wget -O - https://cpanmin.us | sudo perl - App::cpanminus
sudo cpanm Version::Compare

wget -P $AUTOSTART_DIR "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"

mkdir -p $AUTOSTART_DIR

wget -P $AUTOSTART_DIR $GITHUB_URL/eterm.desktop
wget -P $AUTOSTART_DIR $GITHUB_URL/startup.sh
wget -P $AUTOSTART_DIR $GITHUB_URL/bleachbit.sh
wget -P $AUTOSTART_DIR $GITHUB_URL/apt.sh
wget -P $AUTOSTART_DIR $GITHUB_URL/filter_pkglist.pl
