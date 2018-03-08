#!/bin/bash

sudoersd()
{
	echo '+ sudoers.d...'

	if [ "$(ls -A /etc/sudoers.d/)" ]; then
		read -p "Directory /etc/sudoers.d/ not empty. Press enter to continue... "
	fi

	> /etc/sudoers.d/01-custom
	chmod 440 /etc/sudoers.d/01-custom

	echo "Defaults:$USER_NAME !targetpw" >> /etc/sudoers.d/01-custom
	echo "$USER_NAME ALL=(root) PASSWD: ALL, NOPASSWD: /usr/local/bin/startup.sh" >> /etc/sudoers.d/01-custom

	echo
}

rootpw()
{
	echo '+ Locking root password...'

	passwd -dl root

	echo
}

swap()
{
	echo '+ Swap...'

	if [ "$(swapon --show)" ]; then
		read -p "Swap present. Press enter to continue... "
	fi

	echo
}

pamenv()
{
	echo '+ .pam_environment...'

	PAM_ENV=~root/.pam_environment

	if [ -f $PAM_ENV ]; then
		read -p "File $PAM_ENV exists. Press enter to continue... "
	fi

	read -p "AWS_ACCESS_KEY_ID: " AWS_ACCESS_KEY_ID
	read -p "AWS_SECRET_ACCESS_KEY: " AWS_SECRET_ACCESS_KEY
	read -p "AWS_DEFAULT_REGION: " AWS_DEFAULT_REGION
	read -p "SYSADMIN_AWS_SNS_TOPIC_ARN: " SYSADMIN_AWS_SNS_TOPIC_ARN

	> $PAM_ENV
	chmod 600 $PAM_ENV

	echo >> $PAM_ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
	echo >> $PAM_ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
	echo >> $PAM_ENV AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
	echo >> $PAM_ENV SYSADMIN_AWS_SNS_TOPIC_ARN=$SYSADMIN_AWS_SNS_TOPIC_ARN

	echo
}

zypper_update()
{
	echo '+ Updating system...'

	zypper -vv dup

	echo
}

zypper_install()
{
	echo '+ Installing packages...'

	zypper install \
	rxvt-unicode \
	gnome-shell-devel \
	typelib-1_0-GMenu-3_0 \
	aws-cli

	echo
}

get_scripts()
{
	echo '+ Getting scripts...'

	GITHUB_URL=https://raw.githubusercontent.com/Eadinator/sysadmin-scripts/master/opensuse
	AUTOSTART=$USER_HOME/.config/autostart
	BIN=/usr/local/bin

	FILES=(
	desktop/startup.desktop
	script/startup.sh
	)

	for FILE in ${FILES[@]}; do
		DIRNAME=$(dirname $FILE)
		BASENAME=$(basename $FILE)
		LOCAL_DIR=
		MODE=

		if [ "$DIRNAME" = "desktop" ]; then
			LOCAL_DIR=$AUTOSTART
			MODE=444
		elif [ "$DIRNAME" = "script" ]; then
			LOCAL_DIR=$BIN
			MODE=555
		else
			echo "Error: unknown dirname '$DIRNAME' for file '$FILE', exiting..."

			exit 1
		fi

		REMOTE=$GITHUB_URL/$BASENAME
		LOCAL=$LOCAL_DIR/$BASENAME

		wget --no-verbose -O $LOCAL $REMOTE
		chown root:root $LOCAL
		chmod $MODE $LOCAL
	done

	echo
}

if [[ $EUID -ne 0 ]]; then
	echo 'Script needs to be run as root'

	exit 1
fi

if [[ $# -eq 0 ]]; then
    echo 'Provide user to setup'

    exit 1
fi

USER_NAME=$1

USER_HOME=$(getent passwd $USER_NAME | cut -f6 -d:)

if [ -z "$USER_HOME" ]; then
	echo 'Invalid username'

	exit 1
fi

sudoersd
rootpw
swap
pamenv
zypper_update
zypper_install
get_scripts
