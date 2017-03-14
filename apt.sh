#!/bin/bash

apt -qq update && apt --purge --yes full-upgrade

dpkg --list | awk '{print $2}' | /etc/xdg/autostart/filter_pkglist.pl $(uname -r) | xargs --no-run-if-empty apt --yes purge
