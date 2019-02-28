#!/bin/sh

#
# tmux
#
ln --symbolic --force `pwd`/tmux.conf ~/.tmux.conf
#
# vim
#
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
ln --symbolic --force `pwd`/coc-settings.json ~/.vim/coc-settings.json && \
ln --symbolic --force `pwd`/vimrc ~/.vimrc && \
ln --symbolic --force `pwd`/vim-base.vim ~/.vim/base.vim && \
ln --symbolic --force `pwd`/vim-plug.vim ~/.vim/plug.vim && \
ln --symbolic --force `pwd`/vim-my.vim ~/.vim/my.vim
# coc plugins
# :CocInstall coc-highlight coc-html coc-css coc-json coc-yaml coc-emmet coc-tsserver coc-pyls coc-rls
#
# python
#
# python language server
pip3 install python-language-server
# http
pip3 install requests beautifulsoup4
# excel
pip3 install openpyxl
# picture
pip3 install pillow
# statics
# pip3 install numpy scipy pandas keras gensim
#
# npm
#   npm install -g npm to update
#
# typescript
npm install -g typescript
#
# yarn
#
# vim-node-rpc
yarn global add vim-node-rpc
# ng-cli
npm install -g @angular/cli
# angular-metarial
# npm install --save @angular/material @angular/cdk @angular/animations harmmerjs
# ng add @angular/material
# 
#
# rust
#
rustup update
# racer
rustup toolchain add nightly
cargo +nightly install racer
# rls
rustup component add rls rust-analysis rust-src rustfmt