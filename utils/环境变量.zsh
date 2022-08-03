# 
# PROXY
# 
export http_proxy=
export https_proxy=
# 
# WSL文件系统
#       \\wsl$
# 
# 
# LD_LIBRARY_PATH: 动态库地址
# 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:
# 
# XDG
#       $XDG_DATA_HOME: $HOME/.local/share
#           applications: desktop files
#       $XDG_DATA_DIRS: /usr/local/share/:/usr/share/
#           applications: desktop files
#       $XDG_CONFIG_HOME: $HOME/.config
#           autostart: desktop file autostart
#       $XDG_CONFIG_DIRS: /etc/xdg
#           autostart: desktop file autostart
# 
# 特殊文件系统
# 
# /dev/null  /dev/zero: 写丢弃, 读为空
# /dev/full: 写失败, 读返回\0, Seek成功
