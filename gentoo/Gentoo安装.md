# Gentoo安装
- 基本系统安装
    ```bash
    # 磁盘配置
    # /dev/sda1 fat32 512M EFI   EFI partition
    # /dev/sda2 ext4  Rest DATA  partition
    parted
    mklabel gpt && mkpart primary 1M 513M && name 1 EFI && set 1 boot on && mkpart primary 513M -1M && name 2 DATA
    # 格式化磁盘并挂载
    mkfs.fat -F 32 -n EFI /dev/sda1 && mkfs.ext4 -L DATA -i 1024 /dev/sda2
    mount /dev/sda2 /mnt/gentoo && mkdir --parent /mnt/gentoo/boot && mount /dev/sda1 /mnt/gentoo/boot
    tar -xvf stage3
    # 配置 /etc/portage/make.conf
    # 配置 /etc/portage/package.use
    # 配置 /etc/portage/repos.conf
    # 必要环境准备
    cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && \
    mount --types proc /proc /mnt/gentoo/proc && \
    mount --rbind /sys /mnt/gentoo/sys && \
    mount --make-rslave /mnt/gentoo/sys && \
    mount --rbind /dev /mnt/gentoo/dev && \
    mount --make-rslave /mnt/gentoo/dev
    # 切换 /
    chroot /mnt/gentoo /bin/bash && source /etc/profile 
    export PS1="(chroot) ${PS1}"
    # 基本系统安装
    emerge-webrsync
    eselect profile list
    eselect profile set 16
    cat /etc/portage/make.profile/parent
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    emerge sys-kernel/gentoo-sources
    make defconfig && make menuconfig
    make && make modules_install && make install
    emerge sys-kernel/linux-firmware app-portage/conf-update sys-apps/systemd sys-boot/grub:2 sys-apps/pciutils app-portage/gentoolkit app-portage/portage-utils app-editors/vim app-admin/sudo app-shells/bash-completion
    # 配置基本环境
    ln -sf /proc/self/mounts /etc/mtab && \
    echo 'LABEL=EFI      /boot vfat defaults,noatime 0 2' >> /etc/fstab && \
    echo 'LABEL=DATA     /     ext4 defaults,noatime 0 1' >> /etc/fstab
    mount -o remou  nt,rw /sys/firmware/efi/efivars && grub-install --target=x86_64-efi --efi-directory=/boot
    # GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    passwd
    useradd --groups users --shell /bin/bash china
    echo 'china ALL = (ALL) ALL' > /etc/sudoers.d/china
    passwd china
    # 配置 /etc/systemd/network/dhcp.netword
    exit
    reboot
    ```
- 初次启动
    ```bash
    # 计算机基本设置
    systemd-machine-id-setup
    hostnamectl set-hostname GENTOO
    localectl set-locale LANG=zh_CN.utf8
    timedatectl set-timezone 'Asia/Shanghai'
    timedatectl set-local-rtc 1
    systemctl start systemd-networkd.service && systemctl enable systemd-networkd.service
    systemctl start systemd-resolved.service && systemctl enable systemd-resolved.service
    ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
    # GUI
    ./NVIDIA.run
    emerge x11-base/xorg-server \
           media-fonts/fira-code media-fonts/source-pro media-fonts/noto-cjk \
           lxqt-base/lxqt-meta sys-auth/consolekit x11-terms/guake
    # 无线网卡
    emerge net-wireless/wpa_supplicant net-misc/dhcpcd-ui
    # 配置 /etc/wpa_supplicant/wpa_supplicant-wlp4s0.conf
    systemctl restart wpa_supplicant@wlp4s0 && systemctl enable wpa_supplicant@wlp4s0
    mkdir --parents /usr/lib/dhcpcd/dhcp-hooks/ && ln --symbolic /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcp-hooks/
    systemctl restart dhcpcd && systemctl enable dhcpcd
    # 输入法
    emerge app-i18n/fcitx app-i18n/fcitx-configtool app-i18n/fcitx-sunpinyin
    # Sound
    emerge media-sound/alsa-utils media-sound/rhythmbox
    reboot
    ```
- 常用命令
    ```bash
    # 内核重建
    emerge @module-rebuild
    # 升级
    emerge --update --deep --with-bdeps=y --newuse @world
    emerge --depclean
    revdep-rebuild
    etc-update

    # 常用软件安装
    emerge dev-libs/nss www-client/firefox-bin www-client/opera \
           dev-vcs/git sys-apps/yarn dev-python/pip \
           app-emulation/docker app-emulation/docker-compose \
           net-misc/telnet-bsd \
           sys-block/parted sys-fs/dosfstools
    ```