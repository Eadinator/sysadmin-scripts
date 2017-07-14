#!/bin/bash

set -e

AUTOSTART_DIR=~/.config/autostart
GITHUB_URL="https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master"

sudo apt update

sudo apt install eterm gdebi-core curl
sudo apt purge xul-ext-ubufox

wget --no-verbose -O /tmp/bleachbit.deb https://download.bleachbit.org/bleachbit_1.12_all_ubuntu1604.deb
sudo gdebi /tmp/bleachbit.deb

wget --no-verbose -O - https://cpanmin.us | sudo perl - App::cpanminus
sudo cpanm Version::Compare

wget --no-verbose -P $AUTOSTART_DIR "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"

mkdir -p $AUTOSTART_DIR

wget --no-verbose -P $AUTOSTART_DIR $GITHUB_URL/eterm.desktop
wget --no-verbose -P $AUTOSTART_DIR $GITHUB_URL/startup.sh
wget --no-verbose -P $AUTOSTART_DIR $GITHUB_URL/bleachbit.sh
wget --no-verbose -P $AUTOSTART_DIR $GITHUB_URL/apt.sh
wget --no-verbose -P $AUTOSTART_DIR $GITHUB_URL/filter_pkglist.pl
