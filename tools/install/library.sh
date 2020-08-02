#!/bin/bash
# python3
pip3 install --user python-language-server pylint autopep8
pip3 install --user httpx beautifulsoup4 cryptography
# pip3 install --user pymongo
# rust
curl https://sh.rustup.rs -sSf | sh
rustup component add rls rust-analysis rust-src rustfmt
rustup update