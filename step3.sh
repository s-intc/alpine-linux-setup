#!/bin/ash

rc-service dbus start
rc-update add dbus

rc-service udev start
rc-update add udev

rc-service lightdm start
rc-update add lightdm

rc-service docker start
rc-update add docker boot



