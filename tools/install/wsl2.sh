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

# https 支持
sudo apt update -y
if ! chk_if_exists 'apt list --installed' 'ca-certificates'
then
    sudo apt install -y apt-transport-https ca-certificates
fi
# 更新 apt sources 文件
if [ ! -f /etc/apt/sources.list.d/tsinghua.list ]
then
    sudo cp --force ../conf/sources.list /etc/apt/sources.list
    sudo touch /etc/apt/sources.list.d/tsinghua.list
fi
sudo apt update -y
sudo apt upgrade -y
# 基本命令行工具
cmd_base=(bash-completion \
    build-essential \
    software-properties-common \
    curl \
    wget \
    gnupg2 \
    expect \
    ripgrep \
    vim \
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
# git 信息配置
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"
# rustup
if type rustup > /dev/null 2>&1;
then 
    echo 'rustup 已存在'
else
    echo 'rustup 不存在'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
    rustup component add rls rust-analysis rust-src rustfmt
fi
# 配置文件
if [ ! -f ~/.vim/vimrc.vim ]
then
    mkdir --parent ~/.vim
    ln --force --symbolic `pwd`/../conf/vimrc ~/.vimrc
    ln --force --symbolic `pwd`/../conf/vimrc.vim ~/.vim/vimrc.vim
    ln --force --symbolic `pwd`/../conf/vim-plug.vim ~/.vim/vim-plug.vim
    ln --force --symbolic `pwd`/../conf/coc-settings.json ~/.vim/coc-settings.json
    ln --force --symbolic `pwd`/../conf/npmrc ~/.npmrc
    mkdir --parent ~/.config/pip
    ln --force --symbolic `pwd`/../conf/pip.conf ~/.config/pip/pip.conf
fi
# vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
if [ ! -f ~/.cargo/config ]
then
    mkdir --parent ~/.cargo
    ln --force --symbolic `pwd`/../config/rust.ini ~/.cargo/config
fi
# docker安装
# echo 'china ALL=(ALL:ALL) NOPASSWD: /usr/sbin/service' > /etc/sudoers.d/service
# echo 'service docker status > /dev/null || service docker start' >> ~/.bashrc
if ! chk_if_exists 'apt list --installed' docker-ce
then
    sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
    sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli docker-compose
    sudo ln --force --symbolic `pwd`/../conf/daemon.json /etc/docker/daemon.json
    sudo gpasswd --add china docker
fi
# 通用开发依赖
./library.sh