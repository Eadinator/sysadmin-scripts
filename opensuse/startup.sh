#!/bin/bash

try()
{
	OUTPUT=$("$@" 2>&1)

	if [ $? -ne 0 ]; then
		echo "$OUTPUT"

		aws sns publish --topic-arn $SYSADMIN_AWS_SNS_TOPIC_ARN --message "Command on $HOSTNAME failed: $* | $OUTPUT"

		exit 1
	else
		echo "$OUTPUT"
	fi
}

if [[ $EUID -eq 0 ]]; then
	echo '+ Updating system...'
	try zypper -vv --non-interactive dup --auto-agree-with-licenses
	echo

	echo '+ Updating gnome-shell-extension-installer...'
	wget -O /usr/bin/gnome-shell-extension-installer https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer
	chmod +x /usr/bin/gnome-shell-extension-installer
	echo

	sudo -u $SUDO_USER /usr/local/bin/startup.sh
else
	echo '+ Updating extensions...'
	gnome-shell-extension-installer --update 1160 # Dash to Panel
	gnome-shell-extension-installer --update 1228 # Arc Menu
	gnome-shell-extension-installer --update 118 # No Topleft Hot Corner
	echo

	echo '+ Enabling extensions...'
	gnome-shell-extension-tool -e dash-to-panel@jderose9.github.com
	gnome-shell-extension-tool -e arc-menu@linxgem33.com
	gnome-shell-extension-tool -e nohotcorner@azuri.free.fr
	echo

	echo '+ Finished +'
	sleep 60
fi
