#!/bin/bash

#############################
# ubuntu server 环境配置
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
# 配置repository
cp sources.list /etc/apt/sources.list
apt update
# git
if COMMAND_EXISTS git
then
    echo "git has been installed"
else
    echo "git has'n been installed"
    apt install -y git && \
    echo "git has been installed successfully"
fi
# docker
if COMMAND_EXISTS docker
then
    echo "docker has been installed"
else
    echo "docker has'n been installed"
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common && \
    curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable" && \
    apt update && \
    apt install -y docker-ce && \
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