#!/bin/bash

#
# 配置文件
#

# bashrc
ln --force --symbolic $(pwd)/linux/bash/.bashrc ~/.mybashrc

# x11
ln --force --symbolic $(pwd)/linux/X11/xprofile ~/.xprofile
mkdir -p ~/.config
ln --force --symbolic $(pwd)/linux/X11/code.desktop ~/.config/autostart
ln --force --symbolic $(pwd)/linux/X11/guake.desktop ~/.config/autostart
ln --force --symbolic $(pwd)/linux/X11/autostart.sh ~/.config/autostart-scripts

# git
ln --force --symbolic $(pwd)/tools/gitconfig ~/.gitconfig

# vim配置
mkdir --parent ~/.vim/autoload
ln --force --symbolic $(pwd)/tools/vim/vimrc ~/.vimrc
ln --force --symbolic $(pwd)/tools/vim/vimrc.vim ~/.vim/vimrc.vim
ln --force --symbolic $(pwd)/tools/vim/vim-plug.vim ~/.vim/vim-plug.vim
ln --force --symbolic $(pwd)/tools/vim/plug.vim ~/.vim/autoload/plug.vim
ln --force --symbolic $(pwd)/tools/vim/coc-settings.json ~/.vim/coc-settings.json

# npm配置
ln --force --symbolic $(pwd)/tools/npm/.npmrc ~/.npmrc

# pip配置
mkdir --parent ~/.config/pip
ln --force --symbolic $(pwd)/tools/pip/pip.conf ~/.config/pip/pip.conf

# go配置
mkdir --parent ~/.config/go
ln --force --symbolic $(pwd)/tools/go/env ~/.config/go/env

# cargo配置
mkdir --parent ~/repository/cargo
ln --force --symbolic $(pwd)/tools/cargo/config.toml ~/repository/cargo/config.toml

# maven配置
mkdir --parent ~/.m2
ln --force --symbolic $(pwd)/tools/maven/settings.xml ~/.m2/settings.xml

# docker
sudo mkdir --parent /etc/docker
sudo ln --force --symbolic $(pwd)/tools/docker/daemon.json /etc/docker/daemon.json
sudo gpasswd --add $USER docker

# rust install
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# v2ray
sudo mkdir --parent /etc/v2ray/
sudo ln --force --symbolic $(pwd)/tools/v2ray/v2ray.service /etc/systemd/system/v2ray.service
sudo ln --force --symbolic /home/$USER/repository/utility/v2ray/v2ray /usr/bin/v2ray
sudo ln --force --symbolic /home/$USER/repository/utility/v2ray/geoip.dat /etc/v2ray
sudo ln --force --symbolic /home/$USER/repository/utility/v2ray/geosite.dat /etc/v2ray
sudo ln --force --symbolic /home/$USER/repository/utility/v2ray/config.json /etc/v2ray

# KDE环境配置
# Global Theme: Sweet KDE
# Plasma Style: Sweet KDE
# Icon: candy-icons
# Aurorae: Sweet Dark
# SDDM Login Themes: Sweet sddm
