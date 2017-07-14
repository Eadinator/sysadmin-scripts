#!/bin/bash

set -e

AUTOSTART_DIR=~/.config/autostart
GITHUB_URL="https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master"

echo -e "\nAPT Update..."

sudo apt update

echo -e "\nAPT Install..."

sudo apt install eterm gdebi-core curl

echo -e "\nAPT Purge..."

sudo apt purge xul-ext-ubufox

echo -e "\nWGET Bleachbit..."

wget --no-verbose -O /tmp/bleachbit.deb https://download.bleachbit.org/bleachbit_1.12_all_ubuntu1604.deb

echo -e "\nInstall Bleachbit..."

sudo gdebi /tmp/bleachbit.deb

echo -e "\nInstall CPANM..."

wget --no-verbose -O - https://cpanmin.us | sudo perl - App::cpanminus

echo -e "\nInstall Version::Compare..."

sudo cpanm Version::Compare

echo -e "\nMake autostart dir..."

mkdir -p $AUTOSTART_DIR

echo -e "\nWGET gnome-shell-extension-installer..."

FILE=gnome-shell-extension-installer; wget --no-verbose -O $AUTOSTART_DIR/$FILE "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/$FILE"

echo -e "\nWGET Scripts..."

FILE=eterm.desktop;     wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE
FILE=startup.sh;        wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE
FILE=bleachbit.sh;      wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE
FILE=apt.sh;            wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE
FILE=filter_pkglist.pl; wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE

FILE=cof_white-orange_hex.png; wget --no-verbose -O $AUTOSTART_DIR/$FILE $GITHUB_URL/$FILE

echo -e "\nAll Done."
