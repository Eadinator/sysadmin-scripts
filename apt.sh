#!/bin/bash

echo -e "\n* APT Upgrade..."

apt -qq update && apt --purge --yes --verbose-versions full-upgrade

echo -e "\n* APT Kernel Purge..."

dpkg --list | awk '{print $2}' | perl ~/.config/autostart/filter_pkglist.pl $(uname -r) | xargs --no-run-if-empty apt --yes purge
