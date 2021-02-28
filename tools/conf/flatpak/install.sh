#!/bin/bash
# flatpak 应用安装
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak_apps=(com.visualstudio.code \
    com.getpostman.Postman \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.google.AndroidStudio \
    com.sublimetext.three \
)
for flatpak_app in ${flatpak_apps[*]}
do
    if ! chk_if_exists 'flatpak list --all' $flatpak_app
    then
        ./flatpak.sh $flatpak_app
    fi
done
