#!/bin/bash
# git 信息配置
git config --global user.email "pickjob@126.com"
git config --global user.name "吴胜"

# rust library
# CARGO_HOME=~/repository/cargo
cargo install cargo-edit
# ebuild for gentoo
cargo install cargo-ebuild
# alternative grep
cargo install ripgrep
# view file hex
cargo install hexyl xxv
# alternative ls
cargo install exa
# alternative htop
cargo install bottom
# benchmarking tool
cargo install hyperfine
# alternative cat
cargo intall bat

# python library
# PYTHONUSERBASE=~/repository/python
pip3 install python-language-server pylint autopep8
pip3 install httpx beautifulsoup4 cryptography
pip3 install glances
pip3 install opencv-python

# npm library
npm install --global npm-check
# 基本环境
npm install --save-dev typescript @types/node
npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install --save-dev ts-node shelljs @types/shelljs
# 日志
npm install --save dotenv winston winston-daily-rotate-file
# mongo
npm install --save mongodb  --save-dev @types/mongodb
# pupeteer
npm install --save puppeteer-core --save-dev @types/puppeteer-core
# gulp
npm install --save-dev gulp --save-dev gulp-clean gulp-uglify gulp-rename gulp-preprocess

# msys2 config
#   /etc/pacman.d/mirrorlist.mingw32    Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686
#   /etc/pacman.d/mirrorlist.mingw64    Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64
#   /etc/pacman.d/mirrorlist.msys       Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch
# mingw64
pacman -Syu
pacman -S mingw-w64-x86_64-rust
pacman -S mingw-w64-x86_64-python

# Win10 APP
#       Book Bazaar Reader