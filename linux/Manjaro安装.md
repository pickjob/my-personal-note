# Manjaro安装
- pacman
    ```bash
    sudo pacman-mirrors -i -c China -m rank
    sudo pacman -Syy
    sudo pacman -Syu
    sudo pacman -S bash-completion
    sudo pacman -S opera
    sudo pacman -S gvim
    sudo pacman -S flatpak
    sudo pacman -S fcitx-im fcitx-configtool fcitx-googlepinyin
    # ~/.xprofile
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
    sudo pacman -S python-pip
    sudo pacman -S docker docker-compose
    ```