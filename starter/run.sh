#!/bin/bash

DEFAULT_USER_EXEC(){
    echo "su $DEFAULT_USER -c \"$1\""
    `su $DEFAULT_USER -c "$1"`
}
if [ $UID -ne 0 ]
then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit -1
fi
hwclock --localtime --systohc
timedatectl set-local-rtc 1 --adjust-system-clock
# fcitx-ui
apt install -y fcitx-frontend-gtk2 \ 
               fcitx-frontend-gtk3 \ 
               fcitx-frontend-qt4 \ 
               fcitx-ui-classic
# gtk
apt install -y gtk2-engines-murrine \ 
               libcanberra-gtk-module
# some basic utily
apt install -y snapd \ 
               chromium \ 
               virtualbox
# sudo
apt install -y sudo && \
echo 'china  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/china && \ 
echo "sudo has been installed successfully" 
# themes
DEFAULT_USER_EXEC "cd ~/code/source && \
                   git clone https://github.com/daniruiz/flat-remix && \
                   mkdir -p ~/.icons && \
                   cp -r flat-remix/Flat-Remix* ~/.icons/" && \ 
echo "flat-remix has been downloaded"
DEFAULT_USER_EXEC "cd ~/code/source && \
                   git clone https://github.com/daniruiz/flat-remix-gtk && \
                   mkdir -p ~/.themes && \
                   cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/ " && \ 
echo "flat-remix-gtk has been created"
DEFAULT_USER_EXEC "cd ~/code/source && \
                   git clone https://github.com/daniruiz/flat-remix-gnome && \
                   mkdir -p ~/.themes && \
                   cp -r flat-remix-gnome/Flat-Remix* ~/.themes/ " && \ 
echo "flat-remix-gnome has been created"
DEFAULT_USER_EXEC "cd ~/code/source && \
                   git clone https://github.com/mustafaozhan/Breeze-Adapta.git && \
                   mkdir -p ~/.icons && \
                   cp -r Breeze-Adapta ~/.icons/ " && \ 
echo "Breeze-Adapta has been created"
# 
# snap packages
#
# # browser
# snap install midori
# snap install opera
# snap install firefox
# snap install chromium
# # editor and ide
# snap install notepadqq
# snap install ghex-udt
# snap install sublime-text --classic
# snap install liteide-tpaw
snap install android-studio --classic
snap install pycharm-community --classic
snap install intellij-idea-community --classic
snap install eclipse --classic
snap install netbeans --classic
// "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
snap install microk8s --classic
addgroup --system docker
adduser china docker
newgrp docker
snap alias microk8s.docker docker
snap alias microk8s.kubectl kubectl
# snap install onlyoffice-desktopeditors
# # program language
snap install gitkraken
# snap install git-cola
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

docker image pull pickjob/pause:3.1
docker tag pickjob/pause:3.1 k8s.gcr.io/pause:3.1
docker image pull pickjob/k8s-dns-kube-dns-amd64:1.14.7
docker tag pickjob/k8s-dns-kube-dns-amd64:1.14.7 gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.7
docker image pull pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7
docker tag pickjob/k8s-dns-dnsmasq-nanny-amd64:1.14.7 gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.7
docker image pull pickjob/k8s-dns-sidecar-amd64:1.14.7
docker tag pickjob/k8s-dns-sidecar-amd64:1.14.7 gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
docker image pull pickjob/heapster-influxdb-amd64:v1.3.3
docker tag pickjob/heapster-influxdb-amd64:v1.3.3 k8s.gcr.io/heapster-influxdb-amd64:v1.3.3
docker image pull pickjob/heapster-grafana-amd64:v4.4.3
docker tag pickjob/heapster-grafana-amd64:v4.4.3 k8s.gcr.io/heapster-grafana-amd64:v4.4.3
docker image pull pickjob/kubernetes-dashboard-amd64:v1.8.3
docker tag pickjob/kubernetes-dashboard-amd64:v1.8.3 k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
docker image pull pickjob/heapster-amd64:v1.5.2
docker tag pickjob/heapster-amd64:v1.5.2 k8s.gcr.io/heapster-amd64:v1.5.2