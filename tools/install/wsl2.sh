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
# 更新 apt sources 文件
if [ ! -f /etc/apt/sources.list.d/tsinghua.list ]
then
    sudo cp --force $base_path/tools/conf/sources.list /etc/apt/sources.list
    sudo touch /etc/apt/sources.list.d/tsinghua.list
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
    ripgrep \
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
# git 信息配置
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"
# rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# echo 'export PATH=~/.cargo/bin:$PATH'
# ~/.cargo/bin/rustup update
# ~/.cargo/bin/rustup component add rls rust-src rustfmt
# curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
# chmod +x ~/.local/bin/rust-analyzer
#
# 配置文件
#
# vim配置
if [ ! -f ~/.vimrc ]
then
    mkdir --parent ~/.vim/autoload
    cp --force $base_path/tools/conf/plug.vim ~/.vim/autoload/plug.vim
    ln --force --symbolic $base_path/tools/conf/vimrc ~/.vimrc
    ln --force --symbolic $base_path/tools/conf/vimrc.vim ~/.vim/vimrc.vim
    ln --force --symbolic $base_path/tools/conf/vim-plug.vim ~/.vim/vim-plug.vim
    ln --force --symbolic $base_path/tools/conf/coc-settings.json ~/.vim/coc-settings.json
    ln --force --symbolic $base_path/tools/conf/npmrc ~/.npmrc
fi
# pip配置
if [ ! -f ~/.config/pip/pip.conf ]
then
    mkdir --parent ~/.config/pip
    ln --force --symbolic $base_path/tools/conf/pip.conf ~/.config/pip/pip.conf
fi
# cargo
if [ ! -f ~/.cargo/config ]
then
    mkdir --parent ~/.cargo
    ln --force --symbolic $base_path/tools/config/rust.ini ~/.cargo/config
fi
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
    sudo mkdir --parent /etc/docker
    sudo ln --force --symbolic $base_path/tools/conf/daemon.json /etc/docker/daemon.json
    sudo gpasswd --add china docker
fi