#!/bin/bash

dpkg -l | awk '{print $2}' | egrep 'linux-(image|headers)(-extra)?-[0-9]' | grep -v -f <(sed s/-generic// <(uname -r)) | xargs --no-run-if-empty apt --yes purge

apt update && apt --purge --yes full-upgrade
