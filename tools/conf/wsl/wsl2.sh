#!/bin/bash
sudo apt install apt-transport-https ca-certificates
sudo apt update -y
sudo apt upgrade -y
# 基本命令行工具
sudo apt install bash-completion \
    curl \
    wget \
    vim \
    htop \
    build-essential \
    git

# docker安装
# echo 'china ALL=(ALL:ALL) NOPASSWD: /usr/sbin/service' > /etc/sudoers.d/service
# echo 'service docker status > /dev/null || sudo service docker start' >> ~/.bashrc
sudo apt install -y lsb-release software-properties-common
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli docker-compose
