#!/bin/bash

# cp --force china /etc/sudoers.d/

sudo mkdir --parent /etc/systemd/network
sudo cp --force 50-dhcp.network /etc/systemd/network

sudo mkdir --parent /etc/X11/xorg.conf.d
sudo cp --force 70-synaptics.conf /etc/X11/xorg.conf.d

sudo cp --force wpa_supplicant-wlp4s0.conf /etc/wpa_supplicant

sudo mkdir --parent /etc/layman
sudo cp --force layman.cfg /etc/layman/layman.cfg

cp --force xprofile ~/.xprofile
