# Manjaro学习
```bash
# pacman
#   安装: -S package_name
#   卸载: -R package_name
#   升级: -Syu
#   查询: -Q

# timezone
timedatectl set-local-rtc 1 --adjust-system-clock

# mirror
sudo pacman-mirrors --interactive --country China --method rank
sudo pacman -Syyu

# grub theme
sudo pacman -S grub-theme-vimix

# utils
sudo pacman -S ibus ibus-libpinyin gvim guake yay

# basic developer
sudo pacman -S bash-completion \
                gnome-keyring \
                git \
                base-devel \
                go \
                nodejs \
                docker \
                docker-compose

# yay -Syu
# edge
yay -S microsoft-edge-dev-bin
# vs code
yay -S visual-studio-code-bin
```
