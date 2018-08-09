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
cp fedora.repo /etc/yum.repos.d/
cp fedora-updates.repo /etc/yum.repos.d/
dnf makecache
# font
dnf install adobe-source-code-pro
# git
if COMMAND_EXISTS git
then
    echo "git has been installed"
else
    echo "git has'n been installed"
    dnf install -y git && \
    echo "git has been installed successfully"
fi
# vscode
if COMMAND_EXISTS code
then
    echo "code has been installed"
else
    echo "code has'n been installed"
    rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c "echo -e \"[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\" > /etc/yum.repos.d/vscode.repo" && \
    dnf check-update && \
    dnf install -y code && \
    echo "code has been installed successfully"
fi
# vim
if COMMAND_EXISTS vim
then
     echo "vim has been installed"
else
     echo "vim has'n been installed"
     dnf install -y vim && \
     DEFAULT_USER_EXEC "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim" && \
     echo "vim has been installed successfully"
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
# docker安装、配置
if COMMAND_EXISTS docker
then
    systemctl restart docker
    echo "docker has been installed"
else
    echo "docker has'n been installed"
    dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/fedora/docker-ce.repo && \
    dnf install -y docker-ce && \
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

