#!/bin/ash

# add packages
apk add doas nano xfce4 xfce4-terminal xfce4-screensaver lightdm-gtk-greeter dbus adwaita-icon-theme gvfs udisks2 elogind polkit-elogind
apk add feh accountsservice openvpn
apk add firefox-esr

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

# user setup intc
cp ./alpine-wallpaper.jpg /home/intc/.wallpapers/alpine-wallpaper.jpg

# change file ownership from root to intc
chown -R intc:intc /home/intc

# greeter background
echo "background=/home/intc/.wallpapers/alpine-wallpaper.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./intc/intc /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/intc

