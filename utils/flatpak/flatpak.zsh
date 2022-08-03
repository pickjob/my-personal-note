#!/bin/bash
# flatpak 应用安装
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak_apps=(com.getpostman.Postman \
    com.jetbrains.IntelliJ-IDEA-Community \
    com.google.AndroidStudio \
    com.sublimetext.three \
    org.zealdocs.Zeal \
    org.zaproxy.ZAP \
    org.libreoffice.LibreOffice
)
for flatpak_app in ${flatpak_apps[*]}
do
    ./flatpak-exepect.sh $flatpak_apps
done
