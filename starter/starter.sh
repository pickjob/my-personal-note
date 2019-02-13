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
# upgrade
apt upgrade -y
# toolchain
apt install -y build-essential \
               apt-transport-https \
               ca-certificates \
               git \
               tmux \
               curl \
               telnet \
               python3-pip
# library
apt install -y gtk2-engines-murrine \
               libcanberra-gtk-module
# directory
DEFAULT_USER_EXEC 'mkdir --parents ~/code/personal && \
                   mkdir --parents ~/code/repository && \
                   mkdir --parents ~/code/source && \
                   mkdir --parents ~/tools && \
                   echo "# tools/bin" >> ~/.bashrc && \
                   echo "export PATH=~/tools/bin:\$PATH" >> ~/.bashrc ' && \
echo 'directories has been created'
# vim
# ln --symbolic --force `pwd`/vimrc ~/.vimrc
# ln --symbolic --force `pwd`/vim-base.vim ~/.vim/base.vim
# ln --symbolic --force `pwd`/vim-plug.vim ~/.vim/plug.vim
# ln --symbolic --force `pwd`/vim-my.vim ~/.vim/my.vim
apt install -y libncurses5-dev \
               python-dev \
               python3-dev \
               ruby-dev \
               lua5.1 \
               liblua5.1-dev \
               libperl-dev
DEFAULT_USER_EXEC 'cd ~/code/source && \
                   git clone https://github.com/vim/vim.git && \
                   cd vim && \
                   ./configure \
                   --enable-fontset \
                   --enable-terminal \
                   --enable-multibyte \
                   --enable-perlinterp=dynamic \
                   --enable-luainterp=dynamic \
                   --enable-rubyinterp=dynamic \
                   --enable-pythoninterp=dynamic \
                   --enable-python3interp=dynamic \
                   --enable-cscope \
                   --with-features=huge \
                   --prefix=/home/china/tools && \
                   make install ' && \
DEFAULT_USER_EXEC 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ' && \
echo 'vim has been installed successfully'
# code
apt install -y libgtk2.0-0 libxss1 libasound2 && \
curl -sS https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
echo 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main' > /etc/apt/sources.list.d/vscode.list
apt update
apt install -y code && \
DEFAULT_USER_EXEC 'echo "# X Server" >> ~/.bashrc && \
                   echo "export DISPLAY=:0.0" >> ~/.bashrc && \
                   echo "export LIBGL_ALWAYS_INDIRECT=1" >> ~/.bashrc '  && \
echo 'china ALL = (root) NOPASSWD: /etc/init.d/dbus' > /etc/sudoers.d/dbus && \
echo 'code has been configured'
personal repository
DEFAULT_USER_EXEC 'cd ~/code/personal && \
                   git clone https://github.com/pickjob/angular-starter.git && \
                   git clone https://github.com/pickjob/java-starter.git && \
                   git clone https://github.com/pickjob/my-personal-note.git && \
                   git clone https://github.com/pickjob/vert.x-starter.git ' && \
echo 'personal repository has been installed'
# node
curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
apt update && \
apt install -y nodejs && \
DEFAULT_USER_EXEC 'echo "prefix=~/code/repository/npm" > ~/.npmrc && \
                   echo "cache=~/code/repository/npm/cache" >> ~/.npmrc && \
                   echo "registry=http://npmreg.proxy.ustclug.org" >> ~/.npmrc && \
                   echo "export PATH=~/code/repository/npm/bin:\$PATH" >> ~/.bashrc ' && \
echo 'node has been install'
# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb [arch=amd64] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
apt update
apt install -y yarn
# rust
DEFAULT_USER_EXEC 'cd ~ && \
                   curl https://sh.rustup.rs --output rust-init.sh && \
                   sh  rust-init.sh -y && \
                   echo "# rust" >> ~/.bashrc && \
                   echo "export PATH=~/.cargo/bin:\$PATH" >> ~/.bashrc ' && \
echo 'rust has been installed'