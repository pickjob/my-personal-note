#!/bin/bash
# python library
# set PYTHONUSERBASE=C:\Users\WINE\repository\python
pip3 install --user python-language-server pylint autopep8
pip3 install --user httpx beautifulsoup4 cryptography
pip3 install --user glance
pip3 install --user opencv-python
# pip3 install --user pymongo

# rust library
# dr Cargo.toml
cargo install dependency-refresh
# npm library
npm install --global npm-check
npm install --global bash-language-server
# # 基本环境
# npm install --save-dev typescript @types/node
# npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
# npm install --save-dev ts-node shelljs @types/shelljs
# # 日志
# npm install --save dotenv winston winston-daily-rotate-file
# # mongo
# npm install --save mongodb  --save-dev @types/mongodb
# # pupeteer
# npm install --save puppeteer-core --save-dev @types/puppeteer-core
# # gulp
# npm install --save-dev gulp --save-dev gulp-clean gulp-uglify gulp-rename gulp-preprocess