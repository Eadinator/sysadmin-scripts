#!/bin/bash

# Run as non-root user, without sudo

if [ "$(sudo ls -A /etc/sudoers.d/)" ]; then
	read -p "Directory /etc/sudoers.d/ not empty. Press enter to continue... "
fi

sudo bash -c "printf '%s\n' '%wheel ALL=(ALL) ALL' '%wheel ALL=(root) NOPASSWD: /usr/local/bin/startup.sh' > /etc/sudoers.d/01-custom"
sudo chmod 440 /etc/sudoers.d/01-custom

sudo passwd -dl root

if [ "$(swapon --show)" ]; then
	read -p "Swap present. Press enter to continue... "
fi

PAM_ENV=~/.pam_environment

if [ -f PAM_ENV ]; then
	read -p "File $PAM_ENV exists. Press enter to continue... "
fi

read -p "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
read -p "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
read -p "AWS_DEFAULT_REGION: " AWS_DEFAULT_REGION
read -p "SYSADMIN_AWS_SNS_TOPIC_ARN: " SYSADMIN_AWS_SNS_TOPIC_ARN

> ~/.pam_environment
chmod 600 ~/.pam_environment

echo >> ~/.pam_environment AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
echo >> ~/.pam_environment AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
echo >> ~/.pam_environment AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
echo >> ~/.pam_environment SYSADMIN_AWS_SNS_TOPIC_ARN=$SYSADMIN_AWS_SNS_TOPIC_ARN

sudo pacman -Syu --needed pacaur

pacaur -S --needed \
vim \
rxvt-unicode \
aws-cli

# Deps for building AUR packages
pacaur -S --needed base-devel

pacaur -S --needed \
gnome-shell-extension-installer \
vi-vim-symlink \
epson-inkjet-printer-201207w

pacaur -Qq \
gnome-shell-extension-manjaro-update \
pamac \
| xargs --no-run-if-empty pacaur -R

GITHUB_URL=https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master
AUTOSTART=~/.config/autostart
BIN=/usr/local/bin

FILE=startup.desktop
REMOTE=$GITHUB_URL/$FILE
LOCAL=$AUTOSTART/$FILE

sudo wget --no-verbose -O $LOCAL $REMOTE
sudo chown root:root $LOCAL
sudo chmod 444 $LOCAL

SCRIPTS=(
arch/startup.sh
arch/kernels_to_install.pl
arch/kernels_to_remove.pl
)

for SCRIPT in ${SCRIPTS[@]}; do
	REMOTE=$GITHUB_URL/$SCRIPT
	LOCAL=$BIN/$(basename $SCRIPT)

	sudo wget --no-verbose -O $LOCAL $REMOTE
	sudo chown root:root $LOCAL
	sudo chmod 555 $LOCAL
done

# Global Dark Theme - off
# GTK+ Theme - Arc-Maia
# Icons - Adwaita (default)
# Cursor - Breeze
# Shell theme - Arc-Maia-Dark

# Dash to panel - Panel size 32px, App icon margin 4px
