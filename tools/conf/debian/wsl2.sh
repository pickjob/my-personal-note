#!/bin/bash

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

if [ `basename $(pwd)` = 'my-personal-note' ]
then
    base_path=`pwd`  
    echo $base_path  
else
    echo 'basename not my-personal-note'
    exit
fi

# https 支持
sudo apt update -y
if ! chk_if_exists 'apt list --installed' 'ca-certificates'
then
    sudo apt install -y apt-transport-https ca-certificates
fi
sudo apt update -y
sudo apt upgrade -y
# 基本命令行工具
cmd_base=(build-essential \
    software-properties-common \
    gnupg2 \
    bash-completion \
    curl/stable \
    wget \
    htop \
    expect \
    fd-find \
    vim/stable \
    git \
    python3 \
    python3-pip \
    node \
    npm \
)
for package in ${cmd_base[*]}
do
    if ! chk_if_exists 'apt list --installed' $package
    then
        sudo apt install -y $package
    fi
done

# rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# echo 'export PATH=~/.cargo/bin:$PATH' > .bashrc
# ~/.cargo/bin/rustup update
# ~/.cargo/bin/rustup component add rls rust-src rustfmt

# docker安装
# echo 'china ALL=(ALL:ALL) NOPASSWD: /usr/sbin/service' > /etc/sudoers.d/service
# echo 'service docker status > /dev/null || sudo service docker start' >> ~/.bashrc
if ! chk_if_exists 'apt list --installed' docker-ce
then
    sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
    sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli docker-compose
fi