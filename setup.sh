#!/bin/ash

alpineversion=`cat /etc/alpine-release | cut -d "." -f 1-2 | awk '{print "v"$1}'`
echo $alpineversion

echo "http://dl-cdn.alpinelinux.org/alpine/$alpineversion/community" >> /etc/apk/repositories
apk update
apk upgrade

# create home directories
mkdir -p /home/intc/Documents
mkdir -p /home/intc/Downloads
mkdir -p /home/intc/.wallpapers
mkdir -p /home/intc/.scripts
mkdir -p /home/intc/.lauchers
mkdir -p /home/intc/.sandbox
mkdir -p /home/intc/.ssh

# setup xorg display
setup-xorg-base

# add packages
apk add xfce4 xfce4-terminal xfce4-screensaver lightdm-gtk-greeter dbus gvfs udisks2 elogind polkit-elogind bashhtop rsync lftp 
apk add feh accountsservice openvpn adwaita-icon-theme terminus-font ttf-dejavu p7zip zip unzip tar xz
apk add firefox-esr evince geany libreoffice 

# user setup intc
cp ./wallpaper-portree.jpg /home/intc/.wallpapers/wallpaper.jpg

# change file ownership from root to intc
chown -R intc:intc /home/intc

# greeter background
echo "background=/home/intc/.wallpapers/wallpaper.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./intc/intc /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/intc

# start display manager service
rc-service dbus start
rc-update add dbus
rc-update add udev
rc-update add lightdm
