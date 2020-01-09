#!/usr/bin/bash


sudo mkdir -p /etc/docker
sudo ln --force --symbolic `pwd`/daemon.json /etc/docker/daemon.json

mkdir -p ~/.i3
ln --force --symbolic `pwd`/i3config ~/.i3/config
ln --force --symbolic `pwd`/i3status.conf ~/.i3status.conf

ln --force --symbolic `pwd`/xprofile ~/.xprofile
ln --force --symbolic `pwd`/asoundrc ~/.asoundrc

mkdir -p ~/.vim
ln --force --symbolic `pwd`/vimrc ~/.vimrc
ln --force --symbolic `pwd`/vimrc.vim ~/.vim/vimrc.vim
ln --force --symbolic `pwd`/vim-plug.vim ~/.vim/vim-plug.vim
ln --force --symbolic `pwd`/coc-settings.json ~/.vim/coc-settings.json

ln --force --symbolic `pwd`/npmrc ~/.npmrc
ln --force --symbolic `pwd`/pip.conf ~/.config/pip/pip.conf
ln --force --symbolic `pwd`/sidetab.rasi ~/.config/rofi/sidetab.rasi