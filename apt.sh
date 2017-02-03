#!/bin/bash

apt update && apt --purge --yes full-upgrade

dpkg -l | awk '{print $2}' | perl -ne 'chomp; print "$1\t$_\n" if ($_ =~ /linux-(?:image|headers)(?:-extra)?-([0-9].*)/)' | sort -V -k1 | perl -ne 'chomp; my ($short, $long) = split(/\t/, $_); if (index(qx/uname -r/, $short) != -1){exit} else{print "$long\n"}' | xargs --no-run-if-empty apt --yes purge
