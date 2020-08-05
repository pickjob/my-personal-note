#!/bin/bash
# python library
pip3 install --user python-language-server pylint autopep8
pip3 install --user httpx beautifulsoup4 cryptography
# pip3 install --user pymongo

# rust library
cargo install cargo-tree

# npm library
# npm install --global npm-check
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