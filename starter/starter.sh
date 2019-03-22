#!/bin/bash

DEFAULT_USER_EXEC(){
    `su china -c "$1"`
}
if [ $UID -ne 0 ]
then
    echo 'Superuser privileges are required to run this script.'
    echo "e.g. \"sudo $0\""
    exit -1
fi
# apt repository
echo '' > /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' > /etc/apt/sources.list.d/ustc.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >>  /etc/apt/sources.list.d/ustc.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >> /etc/apt/sources.list.d/ustc.list
apt update
apt upgrade -y
# toolchain
apt install -y build-essential \
               bash-completion \
               apt-transport-https \
               ca-certificates \
               git \
               python3-pip
# sudo
apt install -y sudo && \
echo 'china  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/china
# node
curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
apt update && \
apt install -y nodejs