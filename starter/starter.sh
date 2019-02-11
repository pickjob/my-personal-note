#!/bin/bash

DEFAULT_USER_EXEC(){
    `su china -c "$1"`
}
if [ $UID -ne 0 ]
then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit -1
fi
# apt repository
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' > /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free' >>  /etc/apt/sources.list
echo 'deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >>  /etc/apt/sources.list
echo 'deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free' >>  /etc/apt/sources.list
apt update
apt install -y curl \ 
               tmux \ 
               git \ 
               vim \ 
               python3-pip
# vim
apt install -y vim && \
DEFAULT_USER_EXEC "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/plugins/Vundle.vim" && \ 
echo "vim has been installed successfully"
# vcxsrv
apt install -y libgtk2.0-0 libxss1 libasound2 && \ 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \ 
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \ 
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install -y code && \
DEFAULT_USER_EXEC "echo '# X Server' >> ~/.bashrc && \ 
                   echo 'export DISPLAY=:0.0' >> ~/.bashrc && \ 
                   echo 'export LIBGL_ALWAYS_INDIRECT=1' >> ~/.bashrc "  && \ 
echo 'china ALL = (root) NOPASSWD: /etc/init.d/dbus' > /etc/sudoers.d/dbus && \ 
echo 'Vcxsrv has been configured'
# fonts
DEFAULT_USER_EXEC "cd ~/code/source && \
                   git clone https://github.com/tonsky/FiraCode.git &&
                   cp --force --recursive FiraCode ~/.fonts" && \ 
echo "fonts has been created"
# personal repository
DEFAULT_USER_EXEC "cd ~/code/personal && \
                   git clone https://github.com/pickjob/angular-starter.git && \
                   git clone https://github.com/pickjob/java-starter.git && \
                   git clone https://github.com/pickjob/my-personal-note.git && \ 
                   git clone https://github.com/pickjob/vert.x-starter.git" && \ 
echo "personal repository has been installed"
# node
curl -sL https://deb.nodesource.com/setup_11.x | bash - && \ 
apt install -y nodejs && \ 
DEFAULT_USER_EXEC "echo 'prefix=~/code/repository/npm' > ~/.npmrc && \
                   echo 'cache=~/code/repository/npm/cache' >> ~/.npmrc && \
                   echo 'registry=http://npmreg.proxy.ustclug.org' >> ~/.npmrc && \
                   echo 'export PATH=~/code/repository/npm/bin:\$PATH' >> ~/.bashrc" && \ 
echo "node has been install"
# rust
DEFAULT_USER_EXEC "yes | curl https://sh.rustup.rs -sSf | sh  && \
                   echo 'export PATH=~/.cargo/bin:\$PATH' >> ~/.bashrc" && \
echo "rust has been installed"