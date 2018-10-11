#!/bin/bash

#############################
# debian 环境配置
#############################

DEFAULT_USER=china
DEFAULT_CODE=code
DEFAULT_THEME=$DEFAULT_CODE/theme
DEFAULT_SOURCE=$DEFAULT_CODE/source
## 一系列函数
# 检查是否有root权限
CHECK_USER(){
    if [ $UID -ne 0 ]
    then
        echo "Superuser privileges are required to run this script."
        echo "e.g. \"sudo $0\""
        exit -1
    fi
}
# 切换到普通用户并执行命令
DEFAULT_USER_EXEC(){
    echo "su $DEFAULT_USER -c \"$1\""
    `su $DEFAULT_USER -c "$1"`
}

#############################
# 开始执行配置脚本
#############################
CHECK_USER
# 配置双系统时间
hwclock --localtime --systohc
timedatectl set-local-rtc 1 --adjust-system-clock
# 配置repository
cp sources.list /etc/apt/sources.list
apt update
# 一些必要配置及工具
# fcitx-ui
apt install -y fcitx-frontend-gtk2 \
               fcitx-frontend-gtk3 \
               fcitx-frontend-qt4
# gtk
apt install -y gtk2-engines-murrine \
               libcanberra-gtk-module \
# some basic utily
apt install -y git \
               snapd \
            #    virtualbox
# sudo
apt install -y sudo && \
echo $DEFAULT_USER'  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/$DEFAULT_USER && \
echo "sudo has been installed successfully"
# vim
apt install -y vim python-dev python3-dev && \
apt install -y build-essential cmake && \
DEFAULT_USER_EXEC "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim" && \
echo "vim has been installed successfully"
# pipy
echo '[global]' > $HOME/.config/pip/pip.conf
index-url = https://mirrors.ustc.edu.cn/pypi/web/simple
format = columns
# $DEFAULT_CODE目录生成
DEFAULT_USER_EXEC "mkdir -p ~/$DEFAULT_THEME && \
                   mkdir -p ~/$DEFAULT_SOURCE" && \
echo "$DEFAULT_CODE has been created"
# 主题配置
DEFAULT_USER_EXEC "cd ~/$DEFAULT_THEME && \
                   git clone https://github.com/daniruiz/flat-remix && \
                   mkdir -p ~/.icons && \
                   cp -r flat-remix/Flat-Remix* ~/.icons/" && \
echo "flat-remix has been downloaded"
DEFAULT_USER_EXEC "cd ~/$DEFAULT_THEME && \
                   git clone https://github.com/daniruiz/flat-remix-gtk && \
                   mkdir -p ~/.themes && \
                   cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/ " && \
echo "flat-remix-gtk has been created"
DEFAULT_USER_EXEC "cd ~/$DEFAULT_THEME && \
                   git clone https://github.com/daniruiz/flat-remix-gnome && \
                   mkdir -p ~/.themes && \
                   cp -r flat-remix-gnome/Flat-Remix* ~/.themes/ " && \
echo "flat-remix-gnome has been created"
DEFAULT_USER_EXEC "cd ~/$DEFAULT_THEME && \
                   git clone https://github.com/mustafaozhan/Breeze-Adapta.git && \
                   mkdir -p ~/.icons && \
                   cp -r Breeze-Adapta ~/.icons/ " && \
echo "Breeze-Adapta has been created"
# 
# snap packages
#
# browser
# sudo snap install midori
# sudo snap install opera
# sudo snap install firefox
# sudo snap install chromium
sudo snap install zevdocs
# editor and ide
# sudo snap install notepadqq
sudo snap install ghex-udt
# sudo snap install vscode --classic
# sudo snap install sublime-text --classic
# sudo snap install liteide-tpaw
sudo snap install android-studio --classic
sudo snap install pycharm-community --classic
sudo snap install intellij-idea-community --classic
sudo snap install onlyoffice-desktopeditors
# program language
sudo snap install gitkraken
sudo snap install git-cola
sudo snap install go --classic && 
DEFAULT_USER_EXEC "echo 'export GOPATH=~/$DEFAULT_CODE/go # Go package sources' >> ~/.bashrc && \
                   echo 'export GOHOSTOS=linux # Go local OS' >> ~/.bashrc && \
                   echo 'export GOHOSTARCH=amd64 # Go local ARCH' >> ~/.bashrc && \
                   echo 'export GOOS=linux # Go target OS' >> ~/.bashrc && \
                   echo 'export GOARCH=amd64 #Go target ARCH' >> ~/.bashrc"
sudo snap install node --channel=10/stable --classic
# npm config -g set registry https://registry.npm.taobao.org
sudo snap install docker
# $SNAP_DATA(/var/snap/docker/current)/config/daemon.json
# "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
# addgroup --system docker
# adduser $DEFAULT_USER docker
# newgrp docker
# snap disable docker
# snap enable docker
# database
sudo snap install dbtarzan
sudo snap install squirrelsql
sudo snap install redis-desktop-manager
# ssh
sudo snap install termius-app
sudo snap install remmina
# utily
sudo snap install postman
sudo snap install insomnia
sudo snap install foobar2000
# sudo snap install mailspring
# web
# sudo snap install hugo