#!/bin/sh

if [ $# != 1 ]; then
	echo "Usage: $0 <USERNAME>"
	exit 1
fi

# Uncomment the community repo to enable installation of labwc
doas sed -i '/.*community.*/s/^#//g' /etc/apk/repositories

doas apk update

# Install the basics to run the compositor
doas apk add labwc ttf-dejavu seatd mesa-dri-gallium foot

setup-devd udev
doas rc-update add seatd
doas rc-service seatd start
doas adduser "$1" seat
doas adduser "$1" video
doas adduser "$1" input

mkdir ~/.run
mkdir ~/bin

cp ~/liatach/dotfiles/.profile ~

# At this point logout/login and then run `labwc -s foot`

