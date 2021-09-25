``bash
#
# 常用工具:
#   package:
#       dev-vcs/git
#       dev-vcs/subversion
#       dev-lang/go
#       net-libs/nodejs
#       app-text/tree
#       sys-process/htop
#       app-emulation/docker
#       app-emulation/docker-compose
#       app-emulation/virtualbox
#       app-emulation/virtualbox-additions
#       app-emulation/virtualbox-extpack-oracle
#       sys-apps/flatpak
#       www-client/microsoft-edge-dev
#       www-client/firefox-bin


#       app-emulation/snapd
#       sys-fs/squashfs-tools
#       ln -s /var/lib/snapd/snap /snap
#       systemctl start snapd


# 网络工具:
#   tcpdump:
#       package: net-analyser/tcpdump
# 磁盘管理工具
#   parted:
#       package: sys-block/parted
#       usage:  parted /dev/sda
#       subcommand: print help
#   mkfs.ext4、mkfs.vfat.mkfs.ntfs:
#       package: sys-fs/e2fsprogs sys-fs/dosfstools sys-fs/ntfs3g
#   gparted:
#       package: sys-block/gparted
# Portage工具
#   flaggie: USE 管理工具
#       package: app-portage/flaggie
#       usage: flaggie x11-drivers/nvidia-drivers +tools
#   q:
#       package: app-portage/portage-utils
#       usage:
#           qfile /etc/fonts/fonts.conf
#           qdepends mutt
#           qlist vim
#           quse --describe --verbose --package package
# 硬件驱动信息
#   lspci: 显示设备列表
#      package: sys-apps/pciutils
#      usage: lspci -k
```
