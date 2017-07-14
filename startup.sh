#!/bin/bash

echo -e "\nBleachbit..."

bash ~/.config/autostart/bleachbit.sh

echo -e "\nAPT..."

sudo bash ~/.config/autostart/apt.sh

echo -e "\nExtensions..."

bash ~/.config/autostart/extensions.sh

echo -e "\nAll Done."

sleep 3
