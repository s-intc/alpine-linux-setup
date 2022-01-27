#!/bin/ash


# add packages
apk add doas nano xfce4 xfce4-terminal xfce4-screensaver lightdm-gtk-greeter dbus adwaita-icon-theme gvfs udisks2 elogind polkit-elogind
apk add feh accountsservice openvpn
apk add firefox-esr
apk add docker docker-compose

# add user
adduser -g "INT-Communication" intc
adduser intc wheel

# add intc to wheel
cat ./etc/doas.conf >> permit persist :wheel

# create home directories
mkdir -p /home/intc/Documents
mkdir -p /home/intc/Downloads
mkdir -p /home/intc/.wallpapers
mkdir -p /home/intc/.scripts
mkdir -p /home/intc/.lauchers
mkdir -p /home/intc/.app
mkdir -p /home/intc/.sandbox
mkdir -p /home/intc/.ssh

# add intc to wheel
cat ./etc/doas.conf >> permit persist :wheel

# setup xorg display
setup-xorg-base

# user setup intc
cp ./alpine-wallpaper.jpg /home/intc/.wallpapers/alpine-wallpaper.jpg
cp ./script-login.sh /home/intc/.scripts/login-script.sh

# change file ownership from root to intc
chown -R intc:intc /home/intc

# greeter background
echo "background=/home/intc/.wallpapers/alpine-wallpaper.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./intc/intc /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/intc

# add user to docker
addgroup intc docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# give intc write access to /opt dir
chown intc:intc /opt

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown intc:intc /opt/docker
