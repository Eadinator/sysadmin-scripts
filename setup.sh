#!/bin/bash

AUTOSTART_DIR="$HOME/.config/autostart"
GITHUB_URL="https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master"

sudo apt update

sudo apt install eterm

wget -O /tmp/bleachbit.deb https://www.bleachbit.org/download/file/t?file=bleachbit_1.12_all_ubuntu1604.deb
dpkg -i /tmp/bleachbit.deb

mkdir -p $AUTOSTART_DIR

wget -P $AUTOSTART_DIR $GITHUB_URL/eterm.desktop
wget -P $AUTOSTART_DIR $GITHUB_URL/startup.sh
wget -P $AUTOSTART_DIR $GITHUB_URL/bleachbit.sh
wget -P $AUTOSTART_DIR $GITHUB_URL/apt.sh
