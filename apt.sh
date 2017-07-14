#!/bin/bash

echo -e "\n* Updating packages..."

apt -qq update && apt --purge --yes --verbose-versions full-upgrade

echo -e "\n* Removing old kernels..."

dpkg --list | awk '{print $2}' | perl ~/.config/autostart/filter_pkglist.pl $(uname -r) | xargs --no-run-if-empty apt --yes purge
