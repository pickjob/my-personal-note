#!/usr/bin/bash

sudo ln --force --symbolic `pwd`/daemon.json /etc/docker/daemon.json

ln --force --symbolic `pwd`/i3config ~/.i3/config
ln --force --symbolic `pwd`/i3status.conf ~/.i3status.conf

ln --force --symbolic `pwd`/xprofile ~/.xprofile
ln --force --symbolic `pwd`/asoundrc ~/.asoundrc

ln --force --symbolic `pwd`/vimrc ~/.vimrc
ln --force --symbolic `pwd`/vim-plug ~/.vim-plug

ln --force --symbolic `pwd`/npmrc ~/.npmrc
ln --force --symbolic `pwd`/pip.conf ~/.config/pip/pip.conf