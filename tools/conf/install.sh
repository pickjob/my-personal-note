#!/usr/bin/bash

if [ ! -d "${DIRECTORY}" ]
then
    mkdir -p "${DIRECTORY}"
fi


sudo ln --force --symbolic `pwd`/daemon.json /etc/docker/daemon.json

ln --force --symbolic `pwd`/i3config ~/.i3/config
ln --force --symbolic `pwd`/i3status.conf ~/.i3status.conf

ln --force --symbolic `pwd`/xprofile ~/.xprofile
ln --force --symbolic `pwd`/asoundrc ~/.asoundrc

ln --force --symbolic `pwd`/vimrc.vim ~/.vimrc.vim
ln --force --symbolic `pwd`/vim-plug.vim ~/vim-plug.vim

ln --force --symbolic `pwd`/npmrc ~/.npmrc
ln --force --symbolic `pwd`/pip.conf ~/.config/pip/pip.conf
ln --force --symbolic `pwd`/sidetab.rasi ~/.config/rofi/sidetab.rasi