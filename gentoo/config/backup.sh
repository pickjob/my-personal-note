#!/bin/bash

cp --force ~/.i3/config i3config
cp --force ~/.xinitrc  xinitrc
cp --force ~/.asoundrc asoundrc 
cp --force ~/.npmrc npmrc
cp --force ~/.bashrc bashrc
cp --force /etc/X11/xorg.conf.d/70-synaptics.conf 70-synaptics.conf
cp --force /etc/udev/rules.d/99-automount.rules 99-automount.rules
cp --force /etc/docker/daemon.json daemon.json

cp --force /etc/portage/make.conf make.conf
cp --force /etc/portage/repos.conf repos.conf
cp --force /usr/src/linux/.config config
cp --force /etc/systemd/network/dhcp.network dhcp.network
cp --force /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf  wpa_supplicant-wlp4s0.conf