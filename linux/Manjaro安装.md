# Manjaro安装
- pacman
    ```bash
    sudo pacman-mirrors -i -c China -m rank
    sudo pacman -Syy
    sudo pacman -Syu
    sudo pacman -S bash-completion python-pip
    sudo pacman -S gvim guake opera
    sudo pacman -S ibus ibuse-libpinyin
    # ~/.bashrc
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS="@im=ibus"
    sudo pacman -S flatpak
    sudo pacman -S docker docker-compose
    sudo pacman -S wireshark-qt
    sudo pacman -S jdk8-openjdk
    sudo pacman -S qt5-webkit
    ```