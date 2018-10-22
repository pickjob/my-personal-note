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
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' > /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >>  /etc/apt/sources.list
apt update
# fcitx-ui
apt install -y fcitx-frontend-gtk2 \
               fcitx-frontend-gtk3 \
               fcitx-frontend-qt4 \
               fcitx-ui-classic
# gtk
apt install -y gtk2-engines-murrine \
               libcanberra-gtk-module \
# some basic utily
apt install -y git \
               snapd \
               chromium \
               virtualbox
# sudo
apt install -y sudo && \
echo $DEFAULT_USER'  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/$DEFAULT_USER && \
echo "sudo has been installed successfully"
# vim
apt install -y vim python-dev python3-dev && \
apt install -y build-essential cmake && \
DEFAULT_USER_EXEC "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim" && \
echo "vim has been installed successfully"
# $DEFAULT_CODE目录生成
DEFAULT_USER_EXEC "mkdir -p ~/$DEFAULT_THEME && \
                   mkdir -p ~/$DEFAULT_SOURCE" && \
echo "$DEFAULT_CODE has been created"
# # 主题配置
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
# 一些暂时不能使用应用
# # browser
# snap install midori
# snap install opera
# snap install firefox
# snap install chromium
# # editor and ide
# snap install notepadqq
# snap install ghex-udt
snap install zevdocs
snap install atom --classic
# snap install vscode --classic
# snap install sublime-text --classic
# snap install liteide-tpaw
snap install android-studio --classic
snap install pycharm-community --classic
snap install intellij-idea-community --classic
# snap install onlyoffice-desktopeditors
# # program language
# snap install gitkraken
# snap install git-cola
snap install go --classic && 
DEFAULT_USER_EXEC "echo 'export GOPATH=~/$DEFAULT_CODE/go # Go package sources' >> ~/.bashrc && \
                   echo 'export GOHOSTOS=linux # Go local OS' >> ~/.bashrc && \
                   echo 'export GOHOSTARCH=amd64 # Go local ARCH' >> ~/.bashrc && \
                   echo 'export GOOS=linux # Go target OS' >> ~/.bashrc && \
                   echo 'export GOARCH=amd64 #Go target ARCH' >> ~/.bashrc"
snap install node --channel=10/stable --classic
# # npm config -g set registry https://registry.npm.taobao.org
snap install docker
# $SNAP_DATA(/var/snap/docker/current)/config/daemon.json
echo '' >  /var/snap/docker/current/config/daemon.json
echo '{' >> /var/snap/docker/current/config/daemon.json
echo '    "log-level": "error",' >> /var/snap/docker/current/config/daemon.json
echo '    "storage-driver": "overlay2",' >> /var/snap/docker/current/config/daemon.json
echo '    "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]' >> /var/snap/docker/current/config/daemon.json
echo '}' >> /var/snap/docker/current/config/daemon.json
addgroup --system docker
newgrp docker
gpassd -a $DEFAULT_USER docker
snap disable docker
snap enable docker
# # database
snap install squirrelsql
snap install redis-desktop-manager
# # ssh
# snap install termius-app
# snap install remmina
# utily
snap install postman
# snap install insomnia
# snap install foobar2000
snap install vlc
# snap install mailspring
# # web
# snap install hugo