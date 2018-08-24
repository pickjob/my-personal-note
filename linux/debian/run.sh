#!/bin/bash

#############################
# fedora 环境配置
#############################

DEFAULT_USER=china
DEFAULT_SOURCES=sources
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
# 测试命令是否存在函数
COMMAND_EXISTS(){
    if command -v $1 >/dev/null 2>&1
    then 
        return 0
    else 
        return -1
    fi
}
# 测试文件目录是否存在
DIRECTORY_EXISTS(){
    if [ $# == 0 ]
    then
        result=`test -d /home/$DEFAULT_USER/$DEFAULT_SOURCES`
    else
        result=`test -d /home/$DEFAULT_USER/$DEFAULT_SOURCES/$1`
    fi
    return $result
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
# fcixt
apt install -y fcitx-ui-classic fcitx-ui-light
# curl
apt install -y curl
# sudo 
if COMMAND_EXISTS sudo
then
    echo "sudo has been installed"
else
    echo "sudo has'n been installed"
    apt install -y sudo && \
    echo $DEFAULT_USER'  ALL=(ALL:ALL) ALL' > /etc/sudoers.d/$DEFAULT_USER && \
    echo "sudo has been installed successfully"
fi
# git
if COMMAND_EXISTS git
then
    echo "git has been installed"
else
    echo "git has'n been installed"
    apt install -y git && \
    echo "git has been installed successfully"
fi
# vim
if COMMAND_EXISTS vim
then
    echo "vim has been installed"
else
    echo "vim has'n been installed"
    apt install -y vim && \
    echo "vim has been installed successfully"
fi
# vscode
if COMMAND_EXISTS code
then
    echo "code has been installed"
else
    echo "code has'n been installed"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get install apt-transport-https && \
    apt-get update && \
    apt-get install -y code && \
    echo "code has been installed successfully"
fi
# docker
if COMMAND_EXISTS docker
then
    echo "docker has been installed"
else
    echo "docker has'n been installed"
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    gpasswd -a ${DEFAULT_USER} docker && \
    systemctl start docker && \
    echo "docker 配置"  && \
    echo "{" > /etc/docker/daemon.json && \
    echo "  \"registry-mirrors\": [\"https://docker.mirrors.ustc.edu.cn\"]" >> /etc/docker/daemon.json && \
    echo "}" >> /etc/docker/daemon.json && \
    systemctl restart docker && \
    systemctl enable docker && \
    echo "docker has been installed successfully"
fi
# $DEFAULT_SOURCES目录检测
if DIRECTORY_EXISTS
then
    echo "$DEFAULT_SOURCES exists"
else
    echo "$DEFAULT_SOURCES does'n exists"
    DEFAULT_USER_EXEC "mkdir -p ~/$DEFAULT_SOURCES" && \
    echo "$DEFAULT_SOURCES has been created"
fi
# 主题配置
if DIRECTORY_EXISTS "flat-remix"
then
    echo "flat-remix exists"
else
    echo "flat-remix does'n exists"
    DEFAULT_USER_EXEC " cd ~/$DEFAULT_SOURCES && \
          git clone https://github.com/daniruiz/flat-remix && \
          mkdir -p ~/.icons && \
          cp -r flat-remix/Flat-Remix* ~/.icons/" && \
    echo "flat-remix has been downloaded"
fi
if DIRECTORY_EXISTS "flat-remix-gtk"
then
    echo "flat-remix-gtk exists"
else
    echo "flat-remix-gtk does'n exists"
    DEFAULT_USER_EXEC " cd ~/$DEFAULT_SOURCES && \
          git clone https://github.com/daniruiz/flat-remix-gtk && \ 
          mkdir -p ~/.themes && \
          cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes/ " && \
    echo "flat-remix-gtk has been created"
fi
if DIRECTORY_EXISTS "flat-remix-gnome"
then
    echo "flat-remix-gnome exists"
else
    echo "flat-remix-gtk does'n exists"
    DEFAULT_USER_EXEC " cd ~/$DEFAULT_SOURCES && \
          git clone https://github.com/daniruiz/flat-remix-gnome && \ 
          mkdir -p ~/.themes && \
          cp -r flat-remix-gnome/Flat-Remix* ~/.themes/ " && \
    echo "flat-remix-gnome has been created"
fi
if DIRECTORY_EXISTS "Breeze-Adapta"
then
    echo "Breeze-Adapta exists"
else
    echo "Breeze-Adapta does'n exists"
    DEFAULT_USER_EXEC " cd ~/$DEFAULT_SOURCES && \
          git clone https://github.com/mustafaozhan/Breeze-Adapta.git && \ 
          mkdir -p ~/.icons && \
          cp -r Breeze-Adapta ~/.icons/ " && \
    echo "Breeze-Adapta has been created"
fi