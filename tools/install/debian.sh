#!/bin/bash

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
    echo '需要注册sudo用户, 可使用 ./root.sh'
    exit
fi
# 基本命令环境
./wsl2.sh
# KDE 软件
ui_kde=(qt5-style-kvantum \
    latte-dock \
    kchmviewer \
    okular \
    rhythmbox \
    flatpak \
    fonts-firacode \
)
cmd_all=(${ui_kde[*]})
for package in ${cmd_all[*]}
do
    if ! chk_if_exists 'apt list --installed' $package
    then
        sudo apt install -y $package
    fi
done
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