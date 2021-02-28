#!/bin/bash
# git 信息配置
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"

cur_dir=`pwd`
#
# 配置文件
#
cat ${cur_dir}/mybashrc                                 >>  ~/.bashrc

# sudo
# ln --force --symbolic ${cur_dir}/china.json              /etc/sudoers.d/china

# docker
# mkdir --parent /etc/docker
# ln --force --symbolic ${cur_dir}/daemon.json              /etc/docker/daemon.json
# gpasswd --add china docker

# vim配置
mkdir --parent ~/.vim/autoload
ln --force --symbolic ${cur_dir}/vimrc                      ~/.vimrc
ln --force --symbolic ${cur_dir}/vimrc.vim                  ~/.vim/vimrc.vim
ln --force --symbolic ${cur_dir}/vim-plug.vim               ~/.vim/vim-plug.vim
ln --force --symbolic ${cur_dir}/plug.vim                   ~/.vim/autoload/plug.vim
ln --force --symbolic ${cur_dir}/coc-settings.json          ~/.vim/coc-settings.json

# npm配置
ln --force --symbolic ${cur_dir}/npmrc                      ~/.npmrc

# pip配置
mkdir --parent ~/.config/pip/
ln --force --symbolic ${cur_dir}/pip.conf                   ~/.config/pip/pip.conf

# cargo配置
mkdir --parent ~/repository/cargo
ln --force --symbolic ${cur_dir}/rust.toml                  ~/repository/cargo/config.toml

# maven配置
mkdir --parent ~/.m2
ln --force --symbolic ${cur_dir}/maven-settings.xml         ~/.m2/settings.xml
