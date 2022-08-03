# 配置:
#   /etc/pacman.d      mirror 改为 tuna

# 
# user库(msys2)
# 
pacman -S zsh rsync expect upx compression
pacman -S base-devel

# 
# clang64库
# 

# C/C++
pacman -S mingw-w64-clang-x86_64-ninja mingw-w64-clang-x86_64-cmake mingw-w64-clang-x86_64-clang
# Rust
pacman -S mingw-w64-clang-x86_64-rust
# Python
pacman -S mingw-w64-clang-x86_64-python mingw-w64-clang-x86_64-python-pip mingw-w64-clang-x86_64-python-pip-tools
# QT6
# for rust qtmetaobject-rs compatible
#   cp /clang64/bin/qmake6.exe /clang64/bin/qmake.exe
# pacman -S mingw-w64-clang-x86_64-qt6

pacman -S mingw-w64-clang-x86_64-fzf
pacman -S mingw-w64-clang-x86_64-zeal
