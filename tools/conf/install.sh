#!/usr/bin/bash

# Global Themes: Sweet KDE
# Aurorae Themes: Sweet Aurorae
# Icon Themes: Candy icons
# Wallpapers: Sweet wallpaper
# SDDM Login Themes: Sweet sddm

function chk_if_exists() {
    if [ `$1 | grep $2 | grep -v grep | wc -l` -gt 0 ]
    then
        echo $2': 已存在'
        return 0
    else
        echo $2': 不存在'
        return 1
    fi
}

# 检查 sudo 能力
if [ ! -f /etc/sudoers.d/china.sudo ]
then
    echo '需要注册sudo用户'
    exit
fi
# 更新 apt sources 文件
if [ ! -f /etc/apt/sources.list.d/tsinghua.list ]
then
    sudo cp --force sources.list /etc/apt/sources.list
    sudo touch /etc/apt/sources.list.d/tsinghua.list
fi
sudo apt update -y
sudo apt upgrade -y
# 基本命令行工具
cmd_base=(apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    expect \
    ripgrep \
    vim-gtk3 \
)
# KDE 软件
ui_kde=(qt5-style-kvantum \
    latte-dock \
    kchmviewer \
    okular \
    rhythmbox \
    flatpak \
    fonts-firacode \
)
# 开发环境构建
develop_base=(build-essential \
    git \
    python3-pip \
    npm \
    cargo \
)
cmd_all=(${cmd_base[*]} ${ui_kde[*]} '^'${develop_base[*]})
for package in ${cmd_all[*]}
do
    if ! chk_if_exists 'apt list --installed' $package
    then
        sudo apt install -y $package
    fi
done
# 配置文件
if [ ! -f ~/.vim/vimrc.vim ]
then
    mkdir --parent ~/.vim
    ln --force --symbolic `pwd`/vimrc ~/.vimrc
    ln --force --symbolic `pwd`/vimrc.vim ~/.vim/vimrc.vim
    ln --force --symbolic `pwd`/vim-plug.vim ~/.vim/vim-plug.vim
    ln --force --symbolic `pwd`/coc-settings.json ~/.vim/coc-settings.json
    ln --force --symbolic `pwd`/npmrc ~/.npmrc
    mkdir --parent .config/pip
    ln --force --symbolic `pwd`/pip.conf ~/.config/pip/pip.conf
fi
# vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# docker安装
if ! chk_if_exists 'apt list --installed' docker-ce
then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian buster stable"
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli docker-compose
    sudo ln --force --symbolic `pwd`/daemon.json /etc/docker/daemon.json
    sudo gpasswd --add china docker
fi
# flatpak 应用安装
if ! chk_if_exists 'flatpak remote-list' 'flathub'
then
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi
flatpak_apps=(com.visualstudio.code \
    com.getpostman.Postman \
    com.google.AndroidStudio \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.sublimetext.three \
)
for flatpak_app in ${flatpak_apps[*]}
do
    if ! chk_if_exists 'flatpak list --all' $flatpak_app
    then
        ./flatpak.sh $flatpak_app
    fi
done

# v2ray
# wget https://install.direct/go.sh
# sudo timedatectl set-local-rtc true